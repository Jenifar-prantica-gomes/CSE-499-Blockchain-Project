import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class EthereumService {
  final String ip
  final String rpcUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';
  final String privateKey =
      '0d4c6638f633347514c7b088baf9853b19dc5135214f6a58119b1583049a83bd';

  late Web3Client web3Client;
  late Credentials credentials;

  EthereumService() {
    web3Client = Web3Client(rpcUrl, Client());
    final privateKeyHex = '0x' + privateKey;
    credentials = EthPrivateKey.fromHex(privateKeyHex);
  }

  Future<DeployedContract> loadContract() async {
    try {
      final jsonString = await rootBundle.loadString('RQ/Track.json');
      final dynamic json = jsonDecode(jsonString);

      print('Loaded JSON: $json'); // Debugging line to print loaded JSON

      if (json is Map &&
          json.containsKey('networks') &&
          json['networks'] is Map<String, dynamic>) {
        final networks = json['networks'] as Map<String, dynamic>?;
        if (networks?.containsKey('5777') == true &&
            networks!['5777'] is Map<String, dynamic>) {
          final contractAddressHex = networks['5777']!['address'] as String?;
          final contractAddress =
              EthereumAddress.fromHex(contractAddressHex ?? '');
          final contract = DeployedContract(
            ContractAbi.fromJson(jsonEncode(json['abi']), 'Track'),
            contractAddress,
          );
          return contract;
        }
      }
    } catch (e) {
      print('Error loading contract: $e');
      throw Exception('Error loading contract: $e');
    }

    throw Exception('Invalid or missing contract address in JSON');
  }

  Future<String> getContractData() async {
    final contract = await loadContract();
    final function = contract.function('getFarmerInfo');
    final result = await web3Client.call(
      contract: contract,
      function: function,
      params: [],
    );
    return result[0]?.toString() ?? '';
  }

  Future<void> sendTransaction(
    String foodId,
    String foodName,
    String cultivationDate,
    String location,
    String fertilizerType,
  ) async {
    final contract = await loadContract();
    final function = contract.function('addFarmerInfo');
    final transaction = Transaction.callContract(
      contract: contract,
      function: function,
      maxGas: 90000,
      parameters: [
        foodId,
        foodName,
        cultivationDate,
        location,
        fertilizerType,
      ],
    );

    try {
      final response = await web3Client.sendTransaction(
        credentials,
        transaction,
        chainId: 5777, // Ethereum mainnet
      );

      final receipt = await web3Client.getTransactionReceipt(response);
      final transactionHash = receipt?.transactionHash;
      print('Transaction hash: $transactionHash');
    } catch (e) {
      print('Transaction failed: $e');
      throw Exception('Transaction failed: $e');
    }
    getContractData();
  }

  Stream<FilterEvent> listenForDataAccepted() async* {
    final contract = await loadContract();

    final ethFilter = FilterOptions(
      fromBlock: BlockNum.genesis(),
      toBlock: BlockNum.pending(),
    );

    final stream = web3Client.events(ethFilter);

    await for (final event in stream) {
      if (event.topics?.isNotEmpty == true &&
          event.topics![0] != null &&
          event.topics![0] ==
              EthereumAddress.fromHex(contract.address.hex).hex) {
        yield event;
      }
    }
  }
}

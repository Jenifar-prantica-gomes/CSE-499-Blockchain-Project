const Track = artifacts.require("Track");

module.exports = function(deployer) {
  deployer.deploy(Track);
};

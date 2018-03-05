var Voting = artifacts.require("./EngineerCertif.sol");
module.exports = function(deployer) {
  deployer.deploy(EngineerCertif, {gas: 3000000});
};
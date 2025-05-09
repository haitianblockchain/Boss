// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";



contract EsdrasCoin is ERC20Capped, ERC20Burnable  {
    
    address payable public owner;
    uint256 public blockReward;
    
    constructor(uint256 cap, uint256 reward) ERC20("EsdrasCoin", "BOSS") ERC20Capped(cap * (10 ** decimals())) {
       
       owner = payable(msg.sender);
       
        _mint(owner, 70000000 * (10 ** decimals()));

        blockReward = reward * (10 ** decimals());

    }



    function _update(address from, address to, uint256 value) internal virtual override(ERC20Capped, ERC20) {
        super._update(from, to, value);

        if(from == address(0)) {
            uint256 maxSupply = cap();
            uint256 supply = totalSupply();

            if(supply > maxSupply) {
                revert ERC20ExceededCap(supply, maxSupply);
            }
        }
    }


    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function setBlockReward(uint256 reward) public onlyOwner{
    blockReward = reward * (10 ** decimals());
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}
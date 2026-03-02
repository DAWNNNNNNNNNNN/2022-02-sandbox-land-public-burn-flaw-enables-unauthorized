// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VulnerableLand {
    mapping(uint256 => uint256) internal _owners;
    mapping(address => uint256) internal _numNFTPerAddress;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function mint(address to, uint256 id) external {
        require(_owners[id] == 0, "already minted");
        _owners[id] = uint256(uint160(to));
        _numNFTPerAddress[to]++;
        emit Transfer(address(0), to, id);
    }

    function ownerOf(uint256 id) public view returns (address) {
        address owner = address(uint160(_owners[id]));
        require(owner != address(0), "not exist");
        return owner;
    }

    function balanceOf(address owner) external view returns (uint256) {
        return _numNFTPerAddress[owner];
    }

    function _burn(address from, address owner, uint256 id) public {
        require(from == owner, "not owner");
        _owners[id] = 2**160;
        _numNFTPerAddress[from]--;
        emit Transfer(from, address(0), id);
    }
}

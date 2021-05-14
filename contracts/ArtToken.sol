//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.4;

import "hardhat/console.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {
    ERC721URIStorage
} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import { ERC721Enumerable } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ArtToken is ERC721, ERC721Enumerable, ERC721URIStorage,Ownable {
    mapping(uint256 => bool) private buyable;
    mapping(uint256 => uint256) private pricesInWei;

    string private baseURI;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initialBaseURI
    ) ERC721(_name, _symbol) {
        baseURI = _initialBaseURI;
    }

    function buy(uint256 tokenId) external payable {
        require(buyable[tokenId], "ArtToken: Token is not buyable");
        require(
            msg.value >= pricesInWei[tokenId],
            "ArtToken: Insufficient payment"
        );

        transferFrom(ERC721.ownerOf(tokenId), _msgSender(), tokenId);
    }

    function setBuyable(uint256 tokenId, bool isBuyable)
        external
        returns (bool)
    {
        address owner = ERC721.ownerOf(tokenId);

        require(
            owner == _msgSender(),
            "ArtToken: setBuyable only is executable by token owner"
        );
        buyable[tokenId] = isBuyable;

        return true;
    }

    function mint(address _to) external {
        uint256 tokenId = totalSupply();
        _safeMint(_to, tokenId);
    }

    function getBuyable(uint256 tokenId) external view returns (bool) {
        return buyable[tokenId];
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseURI) external onlyOwner() {
        baseURI = _newBaseURI;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}

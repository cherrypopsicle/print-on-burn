//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Burnable3DObject is Ownable, ERC721 {
    mapping(address => bool) public didMint;
    mapping(address => bool) public didBurn;
    uint256 public tokenId = 1;
    string private _base =
        "ipfs://QmXDJeEfaZ9YyF73692TsVGicxyGFaFtwxzwcfBRYj6LaV";
    string private _contractURI = "ipfs://QmXDJeEfaZ9YyF73692TsVGicxyGFaFtwxzwcfBRYj6LaV";
    uint256 private _tokenSupply = 10;

    event Burnt(address indexed burner, string indexed tokenURI);
    event Minted();

    constructor() ERC721("Flaming Collectible", "FLAME") {}

    function mint() public {
        require(tokenId < _tokenSupply, "token supply exceeded!");
        _mint(msg.sender, tokenId++);
        emit Minted();
    }

    function burn(uint256 id) public {
        require(
            ownerOf(id) == msg.sender,
            "Only the owner of the token can burn"
        );
        _burn(id);
        emit Burnt(msg.sender, '');
    }

    // for opensea standards
    function contractURI() public view returns (string memory) {
        return _contractURI;
    }

    // the overridden _baseURI from ERC721
    function _baseURI() internal view virtual override returns (string memory) {
        return _base;
    }

        /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _base;
    }
}

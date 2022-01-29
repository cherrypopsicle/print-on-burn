pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Burnable3DObject is Ownable, ERC721 {

    mapping(address => bool) public didMint;
    mapping(address => bool) public didBurn;
    uint256 public tokenId = 0;
    string private _ipfsFolder = '';
    string private _baseURI = '';
    string private _contractURI = '';
    uint256 private _tokenSupply = 10;

    event Minted();
    event Burnt(address indexed burner, string indexed tokenURI);


    constructor() ERC721("Stuff To Burn And Print With", "Stuff") {}

    function mint() public {
        require(tokenId < _tokenSupply, "token supply exceeded!");
        _mint(msg.sender, tokenId);
    }

    function burn(uint256 id) public {
        require(ownerOf(id) == msg.sender, "Only the owner of the token can burn");
        _burn(id);
    }


    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        require(
            _exists(tokenId),
            "ERC721URIStorage: URI set of nonexistent token"
        );
    }

    // the overridden _baseURI from ERC721
    function _baseURI() internal view virtual override returns (string memory) {
        return _ipfsFolder;
    }
}
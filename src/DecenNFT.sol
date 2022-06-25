// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Strings.sol)

pragma solidity 0.8.13;

import {ERC1155} from "@solmate/tokens/ERC1155.sol";
import {Strings} from "@openzeppelin/utils/Strings.sol";
import {Ownable} from "@openzeppelin/access/Ownable.sol";

/// @title ERC 1155 Oxygen NFT to give away to Oxygen Program members
/// @title DecenNFT
/// @author Jeff Prestes
contract DecenNFT is ERC1155, Ownable {
    using Strings for uint256;

    mapping(uint256 => uint256) public boardCollections;
    mapping(uint256 => string) public boardCollectionsName;
    uint256 public latestBoardCollectionID = 0;
    uint256 public latestTokenID = 0;
    string public baseURI = "https://xpto.com/token/";

    /// @notice Add a Board Collection in the token records
    function addBoardCollection() external onlyOwner {
        latestBoardCollectionID++;
    }

    /// @notice Change the Base URI
    /// @param _newURI the new base URI for the tokens
    function changeBaseURI(string memory _newURI) external onlyOwner {
        baseURI = _newURI;
    }

    /// @notice Mint NFT function.
    /// @param _recipient the recipient of the new token 
    function mintNFT(address _recipient) external onlyOwner {
        latestTokenID++;
        _mint(_recipient, latestTokenID, 1, "");
        boardCollections[latestTokenID] = latestBoardCollectionID;
    }

    /// @notice Return the URI of the specific token.
    /// @param _tokenID the token id. 
    function uri(uint256 _tokenID) public override view virtual returns (string memory) {
        return string.concat(baseURI, _tokenID.toString(), ".json");
    }

    /// @notice Set Board Collection Name
    /// @param _name the new name of the Collection
    /// @param _boardCollectionID the Collection ID
    function setBoardCollectionName(string memory _name, uint256 _boardCollectionID) external onlyOwner {
        boardCollectionsName[_boardCollectionID] = _name;
    } 

    /// @notice Gets Token Collection Name
    /// @param _tokenID the token ID
    function getTokenCollection(uint256 _tokenID) external view returns (string memory) {
        uint256 collectionID = boardCollections[_tokenID];
        return boardCollectionsName[collectionID];
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) public override virtual {
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) public override virtual { }
}
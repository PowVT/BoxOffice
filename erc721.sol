pragma solidity >=0.4.2 <0.9.0;
//SPDX-License-Identifier: 0BSD

//@title ERC721
//@dev Smart contract ERC721 standard copied from ethereum.org

abstract contract ERC721 {
    
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOf(address _owner) external view virtual returns (uint256){}
  
  function ownerOf(uint256 _tokenId) external view virtual returns (address){}
  
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable virtual{}
  
  function approve(address _approved, uint256 _tokenId) external payable virtual{}
}

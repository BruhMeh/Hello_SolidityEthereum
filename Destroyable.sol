pragma solidity ^0.4.16;

import { Owned } from "./Owned.sol";

contract Destroyable is Owned {
    uint idade; 
  function destroy() isOwner public {
    selfdestruct(owner);
  }
}
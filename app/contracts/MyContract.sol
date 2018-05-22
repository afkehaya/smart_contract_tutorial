pragma solidity ^0.4.19;

contract MyContract {
   bool public myBool = false;

   address public myAddress;

   uint8 public myUint8;
   uint256 myUint256;

   string myString = "myString";
   bytes myBytes = "myString";

   constructor() public payable{
       myAddress = msg.sender;
   }

   function fundMyContract() public  payable{

   }

   function withDrawal() public {
       if(myBool == true){
        msg.sender.transfer(address(this).balance);
       }
   }

   function setMyBoolean(bool myBoolArgument) public {
       require(msg.sender == myAddress);
       myBool = myBoolArgument;
   }

   function getMyBoolean() public view  returns(bool) {
       return myBool;
   }


}

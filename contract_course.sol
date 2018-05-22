What we're going to build:

We're building a smart contract that allows the contract creator to deposit money that can only be released when the contract owner sets a boolean value to TRUE.

# First we have to set the pragma line. This lets the compiler know what version we are running.

pragma solidity ^0.4.19;

# Now we have to create the contract. This is similar to a class in other languages.

contract MyContract {

# Now that we have our contract setup, lets create a boolean value so that we can change it later.
# Note, that boolean values are set by default to false.
# We have to make sure that we set the boolean value to "public" so that it can be read. This will allow us to check it's value in remix.

   bool public myBool = false;

# Next, let's create an address variable that we can set the contract creators address to.

   address public myAddress;

# Just for reference, these are some other variables that are available to us.
# We have uint8 - uint256 (unsigned integers). You can also have uint16, uint32, etc all the way to 256.. If you don't know what that is I can explain it to you
# The uint8 in this example is set to public, so it can be read. The uint256 is not public, so it can't be read outside of the contract.

   uint8 public myUint8;
   uint256 myUint256;

# You can also create strings and bytes. A string is a something that can be read by a human. Bytes can't.

   string myString = "myString";
   bytes myBytes = "myString";

# The constructor is a special function that we use to set variables as soon as the contract is deployed. In this case, we are setting myAddress to the msg.sender object
# This message sender object is globally available and represents the account number of the account that created the contract.
# We've made it public so that we can check to verify who the message sender is.

   constructor() public payable{
       myAddress = msg.sender;
   }

# This function allows us to send Ether to the contract. We have to make it both public (so we can see it) and payable so we can send it money.

   function fundMyContract() public  payable{

   }

# This function allows the contract creator to set the value of the boolean variable to true or false. Not that it is public and takes two arguments, the bool argument and the boolean variable
# The if statement checks to see if the msg.sender is equal to the myAddress variable. Remember, we set the my address variable when the contract was "Constructed"
# This means that the myAddress variable must be the account associated with creating the smart contract
# If the msg.sender (person calling this function) isn't the contract creator, the code in this function won't run so the boolean will stay the statement
# However, if the msg.sender IS the contract creator, then he/she will be able to change the boolean to true to allow money to be transfered.
# In this example, we're using "require" instead of an if statement
# It checks to make sure that person trying to change the boolean is the contract owner
# You could also use the word "assert", However, be careful assert will cause any gas spent to be used where as require will just return the gas back to the user.

 function setMyBoolean(bool myBoolArgument) public {
     require(msg.sender == myAddress);
     myBool = myBoolArgument;
  }

# This function allows the second account to withdraw Ether from the smart contract only if the boolean value is set to true
# The function must be public so that it can be called
# The if statment checks if myBool is set to true or false
# If it's true, then the contract transfers the balance of the smart contract to the account calling the function
# It is important to note that there are three addresses involved in the smart contract.
# One is the smart contract creator's address, the second is the person who wants to withdraw Ether, and the third is the Smart contract itself.
# That's right, smart contracts have an address too!
# The piece of code msg.sender.transfer(address(this).balance) is saying "transfer the money that is in this contract to whomever is calling this function"

   function withDrawal() public {
       if(myBool == true){
        msg.sender.transfer(address(this).balance);
       }
   }

# This is just a function so that we can verify that the boolean was changed from false to true

   function getMyBoolean() public view  returns(bool) {
       return myBool;
   }

}

smart_contract_tutorial

 NOTE: This tutorial is still being built. The first section, building your first smart contract in solidity is complete. 
 I'm still working on the sections using Truffle to build the front end of your Dapp that will talk to the Ethereum blockchain. 
 I'll post a video walk through of everything here in the next week or so. 

Building your smart contract in solidity

What we're going to build:

We're building a smart contract that allows the contract creator to deposit money that can only be released when the contract owner sets a boolean value to TRUE.

First we have to set the pragma line. This lets the compiler know what version we are running.

      pragma solidity ^0.4.19;

Now we have to create the contract. This is similar to a class in other languages.

      contract MyContract {

 Now that we have our contract setup, lets create a boolean value so that we can change it later.
 Note, that boolean values are set by default to false.
 We have to make sure that we set the boolean value to "public" so that it can be read. This will allow us to check it's value in remix.

       bool public myBool = false;

 Next, let's create an address variable that we can set the contract creators address to.

      address public myAddress;

 Just for reference, these are some other variables that are available to us.
 We have uint8 - uint256 (unsigned integers). You can also have uint16, uint32, etc all the way to 256.. If you don't know what that is I can explain it to you
 The uint8 in this example is set to public, so it can be read. The uint256 is not public, so it can't be read outside of the contract.

      uint8 public myUint8;
      uint256 myUint256;

 You can also create strings and bytes. A string is a something that can be read by a human. Bytes can't.

       string myString = "myString";
       bytes myBytes = "myString";

The constructor is a special function that we use to set variables as soon as the contract is deployed. In this case, we are setting myAddress to the msg.sender object
This message sender object is globally available and represents the account number of the account that created the contract.
We've made it public so that we can check to verify who the message sender is.

      constructor() public payable{
        myAddress = msg.sender;
       }

This function allows us to send Ether to the contract. We have to make it both public (so we can see it) and payable so we can send it money.

      function fundMyContract() public  payable{

      }

This function allows the contract creator to set the value of the boolean variable to true or false. Not that it is public and takes two arguments, the bool argument and the boolean variable
The if statement checks to see if the msg.sender is equal to the myAddress variable. Remember, we set the my address variable when the contract was "Constructed"
This means that the myAddress variable must be the account associated with creating the smart contract

If the msg.sender (person calling this function) isn't the contract creator, the code in this function won't run so the boolean will stay the statement

However, if the msg.sender IS the contract creator, then he/she will be able to change the boolean to true to allow money to be transfered.

In this example, we're using "require" instead of an if statement
It checks to make sure that person trying to change the boolean is the contract owner
You could also use the word "assert", However, be careful assert will cause any gas spent to be used where as require will just return the gas back to the user.

 function setMyBoolean(bool myBoolArgument) public {
     require(msg.sender == myAddress);
     myBool = myBoolArgument;
  }

This function allows the second account to withdraw Ether from the smart contract only if the boolean value is set to true
The function must be public so that it can be called
The if statment checks if myBool is set to true or false
If it's true, then the contract transfers the balance of the smart contract to the account calling the function
It is important to note that there are three addresses involved in the smart contract.
One is the smart contract creator's address, the second is the person who wants to withdraw Ether, and the third is the Smart contract itself.
That's right, smart contracts have an address too!
The piece of code msg.sender.transfer(address(this).balance) is saying "transfer the money that is in this contract to whomever is calling this function"

      function withDrawal() public {
          if(myBool == true){
           msg.sender.transfer(address(this).balance);
         }
    }

This is just a function so that we can verify that the boolean was changed from false to true

    function getMyBoolean() public view  returns(bool) {
       return myBool;
      }

   }

NOTE: This section is not complete as of May 22 2018. I'm working on finishing it so that you can learn how to connect your smart contract to the ethereum blockchain and deploy a UI for your dapp

How to work with Truffle:

Truffle is the most popular developer framework for building Dapps on Ethereum
Go ahead and type the following command to install it from your command line.
Hang tight, it may take a minute

 http://truffleframework.com/

      npm install -g truffle

 Once that is installed we'll want to add a "Box" so that we can use a web development framework and package manage.
 We'll use webpack
 http://truffleframework.com/boxes/webpack
 Follow the instructions on the page.
 Webpack lets us use static HTMl and JS

 Truffle App Structrue
    - Test folder is for testing
    - Migrations let truffle know what contracts to deploy on the network
    - Contracts contains all our solidity files
    - App folder has all our html and JS

 You can just delete the example project or leave it in there if you want to play around.
 Steps for setting up your contract in truffleframework

1. remove convertlib and metacoin files
2. Create a new file in the contracts directory called MyContract.sol
3. Copy your smart contract from remix over to this new file.
4. go to the migrations folder and leave the initial migrations file as is.
5. Adapt the deploy contracts migration: change the first line to be : var MyContract = artifacts.require("./MyContract.sol");
 This file will convert the solidity file into a JSON file and tell truffle what to do with it.
6. Delete the second line.
7. Change line four to be   
             
       deployer.deploy(MyContract);
             
8. Finally, remove the meta coin JS file from the test directory

 NOTE, we aren't covering writing tests in this tutorial but it's something you should research on your own.

 Understanding truffle contracts and artifacts

 If you write in your console

     truffle compile

 Then truffle will try to compile your smart contract to our JSON file as an artifact.
 Once this is done, check the build folder.

 I got an error message here that siad "Cannot find module 'babel-register".
 If you get an error message copy and paste it into google and start digging around on Stack Overflow.
 You will eventually find an answer.

 Now you should have a Build folder

 In the build folder you will have a JSON file with an ABI array.

 The abi array lets us know what inputs we can have when interacting with the contract and what will be returned.

 Now we are ready to interact with the truffle contract library

 You can find this file in app/javascripts/app.js file. Go ethereum

 Change line nine to

import metacoin_artifacts from '../../build/contracts/MyContract.json'

 This imports the artifact (that JSON file that we compiled our contract to)

 The truffle contract is an abstraction of Web3 which allows our smart contract to interact with the blockchain node.

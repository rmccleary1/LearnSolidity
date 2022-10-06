//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0; /*tells compiler which version of solidity program we want to use*/

/*Variables, Data Types, Costumer data structures*/

contract MyContract {
    //State variables vs
    string public myString = "Hello, World";
    bytes32 myBytes32 = "Hello, World"; /*String like - performance better due to length*/
    uint public myUint = 1; /*state variable stored on the block chain*/
    int public myInt = 1;
    uint256 public myUint256 = 1; /*Variable length 256*/
    uint8 public myUint8 = 1;  /*Variable length 8*/
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; /*Variable type for addresses*/
    
    /*struct is a way to model arbritary data; can be person, vote, etc...*/
    struct MyStruct {
        uint myInt;
        string myString;
    }
    MyStruct public myStruct = MyStruct(1, "Hello, World");

    /*other examples of struct
    struct Person {
        uint id;
        string name
    }
    struct Vote {
        uint id
        string partyaffiliation
        string precinct 
    }*/
    
    //Local variables
    function getValue() public pure returns(uint) {
        uint value = 1; /*unassigned integer i.e. can't have sign in front*/
        return value;

        /*value is only available inside this function*/
    }
}

/*Arrays and Mapping*/

contract MyContract2 {
    //Array
      /*with array each row and col is assigned with an index starting at 0. Count row first then column. index starts at 0 to n-1 (n being rows) or 0 to m-1 (m being columns)*/
    uint[] public uintArray = [1,2,3]; /*Creates array of unassigned integers*/
    string[] public stringArray = ["apple","banana","carrot"]; /*Creates array of strings*/
    string[] public values; /*empty array, can add things to it late via a function*/
    uint[][] public array2D = [ [1,2,3], [4,5,6]] ; 

    function addValue(string memory _value) public{
        values.push(_value); /*push() takes an argument and adds item to end of an array*/
    }
    function valueCount() public view returns(uint){
        return values.length; /*returns length of array*/
    }

}

/*Data Mappings*/
   /*Similar to array*/
   /*Key value store where you can look things up based on a key and get things back*/
    /*Arrays are 0 based indexed, but with mapping the key (what you refer the data cell too) can be anything*/
    /*Makes blockchain works like a database where you can just look things up*/
contract MyContract3 {
   /*ex: mapping(key => value) mappingName;*/
   mapping(uint => string) public names;
   mapping(uint => Book) public books;
   /*Nesting mapping. Mapping inside of mapping*/    
    //mapping(key => mapping(key2 => value2) public myMapping)
    mapping(address => mapping(uint => Book)) public myBooks; /*pass in address and get all books related to address ID*/

   /*rememer constructor functions only run once when initialized to blockchain*/
   constructor() public {
       names[1] = "Adam"; /*names with ID of 1 is equal to Adam*/
       names[2] = "Bruce";
       names[3] = "Carl";
   }
    /*reminder that strict is way to model arbitrary data. Like create dataset*/
    struct Book {
        string title;
        string author;
    }  /*not public. doesn't show up when deploy*/

    function addBook(uint _id, string memory _title, string memory _author) public {
        books[_id] = Book(_title, _author);
    } /*this function addBook used to create key is mapping book through input, and with input
        from title and author, puts results in struct Book. In which struct Book is used as a value
        for mapping books.*/

    function addMyBook(uint _id, string memory _title, string memory _author) public {
        //myBooks[key1][key2] = Book(_title, _author)
        myBooks[msg.sender][_id] = Book(_title, _author);   /*solidity has a global variable called msg.sender that allows you to capture address of person calling function*/ 
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./SocialMediaFactory.sol";

contract SocialMedia {
    uint256 public latestTweetId;
    uint256 public newGroupId;
    uint256 public likesCount;
    address owner;

    struct Post {
        uint256 postId;
        address author;
        string description;
        string content;
        uint256 commentCount;
        uint likes;
    }

    struct User {
        address userAddress;
        string username;
        uint256[] userGroups;
        // mapping(uint256 => uint256) userTweets;
    }

    struct Group {
        uint256 groupId;
        string groupName;
        address[] members;
    }

    mapping(address => bool) hasRegistered;

    mapping(uint256 => Post) public tweets;

    mapping(address => User) public users;

    mapping(uint256 => Group) public groups;

    User[] myUsers;
    Post[] allTweetsArray;

    NftFactory public nftFactoryContract; // Instance of the NftFactory contract

    constructor(address _nftFactoryAddress) {
        nftFactoryContract = NftFactory(_nftFactoryAddress);
        owner = msg.sender;
    }

    function signUp(string memory _username) external {
        require(msg.sender != address(0));
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(!hasRegistered[msg.sender], "User not registered");

        User storage _user = users[msg.sender];

        _user.userAddress = msg.sender;

        _user.username = _username;

        users[msg.sender];

        myUsers.push(_user);

        // hasRegistered[msg.sender] = true;
    }

    function signIn() public {
        require(msg.sender != address(0));
        require(hasRegistered[msg.sender], "User not registered");
        hasRegistered[msg.sender] = true;
    }

    // Function to create a tweet
    function createPost(
        string memory _description,
        string memory _content,
        string memory uri
    ) public {
        require(msg.sender != address(0));
        require(hasRegistered[msg.sender], "User not registered");

        signIn();
        latestTweetId++;
        tweets[latestTweetId] = Post(
            latestTweetId,
            msg.sender,
            _description,
            _content,
            0,
            0

        );
        tweets[latestTweetId].likes++;
        likesCount++;
        allTweetsArray.push(tweets[latestTweetId]);
        // users[msg.sender].userTweets[latestTweetId] = latestTweetId;

        nftFactoryContract.createNFT(msg.sender, latestTweetId, uri);
    }

    // Function to create a group
    function createGroup(string memory _groupName) public {
        require(msg.sender != address(0));
        signIn();
        require(hasRegistered[msg.sender], "User not registered");
        newGroupId++;
        groups[newGroupId] = Group(newGroupId, _groupName, new address[](0));
        users[msg.sender].userGroups.push(newGroupId);
    }

    // Function to update a post
    function updatePost(uint256 _postId, string memory _newContent) public {
        require(msg.sender != address(0));
        signIn();
        require(hasRegistered[msg.sender], "User not registered");
        require(tweets[_postId].postId != 0, "Post does not exist");
        require(
            tweets[_postId].author == msg.sender,
            "Only the author can update the post"
        );

        tweets[_postId].content = _newContent;
    }

    // Function to delete a post
    function deletePost(uint256 _postId) public {
        require(msg.sender != address(0));
        require(tweets[_postId].postId != 0, "Post does not exist");
        require(tweets[_postId].author == msg.sender, "Only author can delete");
        delete tweets[_postId];
    }

    function getAllUsers() external view returns (User[] memory) {
        require(msg.sender != address(0));
        OnlyOnwer();
        return myUsers;
    }

    function getAllPost() external returns (Post[] memory) {
        require(msg.sender != address(0));
        signIn();
        require(hasRegistered[msg.sender], "User not registered");
        return allTweetsArray;
    }

    function OnlyOnwer() private view {
        require(owner == msg.sender, "Your are not the owner");
    }
}

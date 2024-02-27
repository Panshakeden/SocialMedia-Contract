// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SocialMedia {
    uint256 public latestTweetId;
    uint256 public newGroupId;
    struct Post {
        uint256 postId;
        address author;
        string content;
        uint256 commentCount;
    }

    struct User {
        address userAddress;
        string username;
        uint256[] userGroups;
        mapping(uint256 => uint256) userTweets;
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

    function signUp(string memory _username) external {
        User storage _user = users[msg.sender];

        _user.userAddress = msg.sender;

        _user.username = _username;

        users[msg.sender];
        // require(!hasRegistered[msg.sender]);
        hasRegistered[msg.sender] = true;
    }

    function signIn() external {
        require(hasRegistered[msg.sender]);
        hasRegistered[msg.sender] = true;
    }

    // Function to create a tweet
    function createPost(string memory _content) public {
        latestTweetId++;
        tweets[latestTweetId] = Post(latestTweetId, msg.sender, _content, 0);
        users[msg.sender].userTweets[latestTweetId] = latestTweetId;
    }

    // Function to create a group
    function createGroup(string memory _groupName) public {
        newGroupId++;
        groups[newGroupId] = Group(newGroupId, _groupName, new address[](0));
        users[msg.sender].userGroups.push(newGroupId);
    }
}

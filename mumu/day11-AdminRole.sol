// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title AdminRole
 * @author mumu
 * @notice 管理员角色管理
 * @dev 支持设置多个管理员，提供添加和移除管理员的功能。事件记录管理员变更，增强透明度和安全性。
  继承Ownable合约，利用所有权控制管理员权限。owner可以添加或移除管理员，管理员可以执行特定管理任务，但不能转移所有权。
*/

contract AdminRole is Ownable {
    mapping(address => bool) private admins;

    // 事件：当管理员被添加或移除时触发
    event AdminAdded(address indexed admin, uint256 timestamp);
    event AdminRemoved(address indexed admin, uint256 timestamp);

    // 添加管理员，只有所有者可以调用
    function addAdmin(address _admin) public onlyOwner {
        require(_admin != address(0), "Invalid admin address");
        require(!admins[_admin], "Address is already an admin");

        admins[_admin] = true;
        emit AdminAdded(_admin, block.timestamp); // 记录管理员添加事件
    }

    // 移除管理员，只有所有者可以调用
    function removeAdmin(address _admin) public onlyOwner {
        require(admins[_admin], "Address is not an admin");

        admins[_admin] = false;
        emit AdminRemoved(_admin, block.timestamp); // 记录管理员移除事件
    }

    // 检查地址是否是管理员
    function isAdmin(address _admin) public view returns (bool) {
        return admins[_admin];
    }
}

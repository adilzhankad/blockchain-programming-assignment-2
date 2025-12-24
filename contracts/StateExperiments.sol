// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StateExperiments {
    struct Person {
        string name;
        uint256 age;
    }

    Person public p;

    constructor(string memory name_, uint256 age_) {
        p = Person({name: name_, age: age_});
    }

    // EXP 1 (WRONG): изменяем memory-копию -> storage НЕ меняется
    function exp1_wrongMemoryUpdate(uint256 newAge) external {
        Person memory copy = p;   // COPY in memory
        copy.age = newAge;        // changes only memory copy
        // p.age stays unchanged
    }

    // EXP 1 (CORRECT): изменяем storage-ссылку -> storage МЕНЯЕТСЯ
    function exp1_correctStorageUpdate(uint256 newAge) external {
        Person storage ref = p;   // REFERENCE to storage
        ref.age = newAge;         // writes to storage
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasOptimization {
    uint256[] public arr;

    function reset() public {
        delete arr;
    }

    // A) Naive
    function pushNaive(uint256 n) public {
        for (uint256 i = 0; i < n; i++) {
            arr.push(i);
        }
    }

    // B) Optimized: cached + unchecked
    function pushOptimized(uint256 n) public {
        uint256[] storage a = arr;
        for (uint256 i = 0; i < n; ) {
            a.push(i);
            unchecked { i++; }
        }
    }

    // C) Extreme: set length ONCE + store by index (assembly)
    function pushExtreme(uint256 n) public {
        uint256 start = arr.length;

        // increase length once
        assembly {
            sstore(arr.slot, add(sload(arr.slot), n))
        }

        // base slot of array data = keccak256(arr.slot)
        bytes32 base;
        assembly {
            mstore(0x00, arr.slot)
            base := keccak256(0x00, 0x20)
        }

        // write elements directly: arr[start + i] = i
        for (uint256 i = 0; i < n; ) {
            bytes32 pos = bytes32(uint256(base) + (start + i));
            assembly {
                sstore(pos, i)
            }
            unchecked { i++; }
        }
    }
}
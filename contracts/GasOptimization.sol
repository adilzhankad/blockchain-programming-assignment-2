// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasOptimization {
    uint256[] public arr;

    // Version A: naive
    function pushNaive(uint256 n) external {
        for (uint256 i = 0; i < n; i++) {
            arr.push(i);
        }
    }

    // Version B: optimized (cache length + use local)
    function pushOptimized(uint256 n) external {
        uint256 i = 0;
        while (i < n) {
            arr.push(i);
            unchecked { i++; } // safe because i < n and n is uint256
        }
    }

    // Version C: more optimized (cache arr reference, minimize repeated reads)
    function pushExtreme(uint256 n) external {
        uint256[] storage a = arr; // storage reference caching
        for (uint256 i = 0; i < n; ) {
            a.push(i);
            unchecked { i++; }
        }
    }

    function reset() external {
        delete arr;
    }

    function length() external view returns (uint256) {
        return arr.length;
    }
}

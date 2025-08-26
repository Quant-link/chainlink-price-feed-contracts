// SPDX-License-Identifier: MIT
pragma solidity >=0.8.28;

/**
 * @title ChainlinkConfig
 * @notice Configuration contract containing Chainlink price feed addresses for different networks
 * @dev This contract provides a centralized location for all Chainlink price feed addresses
 *      across multiple blockchain networks. It includes validation and helper functions.
 */
library ChainlinkConfig {
    // Network identifiers
    uint256 public constant ETHEREUM_MAINNET = 1;
    uint256 public constant POLYGON_MAINNET = 137;
    uint256 public constant ARBITRUM_ONE = 42161;
    uint256 public constant OPTIMISM_MAINNET = 10;
    uint256 public constant BASE_MAINNET = 8453;
    uint256 public constant AVALANCHE_MAINNET = 43114;
    uint256 public constant SEPOLIA_TESTNET = 11155111;

    // Price feed identifiers
    bytes32 public constant ETH_USD = keccak256("ETH/USD");
    bytes32 public constant BTC_USD = keccak256("BTC/USD");
    bytes32 public constant LINK_USD = keccak256("LINK/USD");
    bytes32 public constant USDC_USD = keccak256("USDC/USD");
    bytes32 public constant USDT_USD = keccak256("USDT/USD");
    bytes32 public constant DAI_USD = keccak256("DAI/USD");
    bytes32 public constant MATIC_USD = keccak256("MATIC/USD");
    bytes32 public constant AVAX_USD = keccak256("AVAX/USD");

    // Configuration constants
    uint256 public constant DEFAULT_STALENESS_THRESHOLD = 3600; // 1 hour
    uint256 public constant DEFAULT_DEVIATION_THRESHOLD = 500; // 5% in basis points
    uint256 public constant DEFAULT_HEARTBEAT_INTERVAL = 300; // 5 minutes
    uint8 public constant DEFAULT_MIN_ANSWERS = 1;
    uint256 public constant DEFAULT_MAX_GAS_PRICE = 100_000_000_000; // 100 gwei

    /**
     * @notice Get price feed address for a specific network and pair
     * @param chainId The blockchain network identifier
     * @param pairId The price pair identifier (e.g., ETH_USD)
     * @return feedAddress The Chainlink price feed address
     */
    function getPriceFeedAddress(uint256 chainId, bytes32 pairId) internal pure returns (address feedAddress) {
        if (chainId == ETHEREUM_MAINNET) {
            return _getMainnetFeed(pairId);
        } else if (chainId == POLYGON_MAINNET) {
            return _getPolygonFeed(pairId);
        } else if (chainId == ARBITRUM_ONE) {
            return _getArbitrumFeed(pairId);
        } else if (chainId == OPTIMISM_MAINNET) {
            return _getOptimismFeed(pairId);
        } else if (chainId == BASE_MAINNET) {
            return _getBaseFeed(pairId);
        } else if (chainId == AVALANCHE_MAINNET) {
            return _getAvalancheFeed(pairId);
        } else if (chainId == SEPOLIA_TESTNET) {
            return _getSepoliaFeed(pairId);
        }
        
        revert("ChainlinkConfig: Unsupported network or pair");
    }

    /**
     * @notice Check if a price feed is supported on a specific network
     * @param chainId The blockchain network identifier
     * @param pairId The price pair identifier
     * @return supported True if the price feed is supported
     */
    function isPriceFeedSupported(uint256 chainId, bytes32 pairId) internal pure returns (bool supported) {
        if (chainId == ETHEREUM_MAINNET) {
            return _isMainnetPairSupported(pairId);
        } else if (chainId == POLYGON_MAINNET) {
            return _isPolygonPairSupported(pairId);
        } else if (chainId == ARBITRUM_ONE) {
            return _isArbitrumPairSupported(pairId);
        } else if (chainId == OPTIMISM_MAINNET) {
            return _isOptimismPairSupported(pairId);
        } else if (chainId == BASE_MAINNET) {
            return _isBasePairSupported(pairId);
        } else if (chainId == AVALANCHE_MAINNET) {
            return _isAvalanchePairSupported(pairId);
        } else if (chainId == SEPOLIA_TESTNET) {
            return _isSepoliaPairSupported(pairId);
        }

        return false;
    }

    // Internal functions for each network
    function _getMainnetFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
        if (pairId == BTC_USD) return 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c;
        if (pairId == LINK_USD) return 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c;
        if (pairId == USDC_USD) return 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6;
        if (pairId == USDT_USD) return 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
        if (pairId == DAI_USD) return 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;
        if (pairId == MATIC_USD) return 0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676;
        revert("ChainlinkConfig: Unsupported pair on Ethereum Mainnet");
    }

    function _getPolygonFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0xF9680D99D6C9589e2a93a78A04A279e509205945;
        if (pairId == BTC_USD) return 0xc907E116054Ad103354f2D350FD2514433D57F6f;
        if (pairId == LINK_USD) return 0xd9FFdb71EbE7496cC440152d43986Aae0AB76665;
        if (pairId == USDC_USD) return 0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7;
        if (pairId == USDT_USD) return 0x0A6513e40db6EB1b165753AD52E80663aeA50545;
        if (pairId == MATIC_USD) return 0xAB594600376Ec9fD91F8e885dADF0CE036862dE0;
        revert("ChainlinkConfig: Unsupported pair on Polygon");
    }

    function _getArbitrumFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
        if (pairId == BTC_USD) return 0x6ce185860a4963106506C203335A2910413708e9;
        if (pairId == LINK_USD) return 0x86E53CF1B870786351Da77A57575e79CB55812CB;
        if (pairId == USDC_USD) return 0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3;
        if (pairId == USDT_USD) return 0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7;
        revert("ChainlinkConfig: Unsupported pair on Arbitrum");
    }

    function _getOptimismFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
        if (pairId == BTC_USD) return 0xD702DD976Fb76Fffc2D3963D037dfDae5b04E593;
        if (pairId == LINK_USD) return 0xCc232dcFAAE6354cE191Bd574108c1aD03f86450;
        if (pairId == USDC_USD) return 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3;
        if (pairId == USDT_USD) return 0xECef79E109e997bCA29c1c0897ec9d7b03647F5E;
        revert("ChainlinkConfig: Unsupported pair on Optimism");
    }

    function _getBaseFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70;
        if (pairId == BTC_USD) return 0x56a43EB56Da12C0dc1D972ACb089c06a5dEF8e69;
        if (pairId == LINK_USD) return 0xb113F5A928BCfF189C998ab20d753a47F9dE5A61;
        if (pairId == USDC_USD) return 0x7e860098F58bBFC8648a4311b374B1D669a2bc6B;
        revert("ChainlinkConfig: Unsupported pair on Base");
    }

    function _getAvalancheFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x976B3D034E162d8bD72D6b9C989d545b839003b0;
        if (pairId == BTC_USD) return 0x2779D32d5166BAaa2B2b658333bA7e6Ec0C65743;
        if (pairId == LINK_USD) return 0x49ccd9ca821EfEab2b98c60dC60F518E765EDe9a;
        if (pairId == USDC_USD) return 0xF096872672F44d6EBA71458D74fe67F9a77a23B9;
        if (pairId == USDT_USD) return 0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a;
        if (pairId == AVAX_USD) return 0x0A77230d17318075983913bC2145DB16C7366156;
        revert("ChainlinkConfig: Unsupported pair on Avalanche");
    }

    function _getSepoliaFeed(bytes32 pairId) private pure returns (address) {
        if (pairId == ETH_USD) return 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        if (pairId == BTC_USD) return 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43;
        if (pairId == LINK_USD) return 0xc59E3633BAAC79493d908e63626716e204A45EdF;
        revert("ChainlinkConfig: Unsupported pair on Sepolia");
    }

    // Helper functions to check if pairs are supported on each network
    function _isMainnetPairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD ||
               pairId == USDC_USD || pairId == USDT_USD || pairId == DAI_USD || pairId == MATIC_USD;
    }

    function _isPolygonPairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD ||
               pairId == USDC_USD || pairId == USDT_USD || pairId == MATIC_USD;
    }

    function _isArbitrumPairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD ||
               pairId == USDC_USD || pairId == USDT_USD;
    }

    function _isOptimismPairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD ||
               pairId == USDC_USD || pairId == USDT_USD;
    }

    function _isBasePairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD || pairId == USDC_USD;
    }

    function _isAvalanchePairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD ||
               pairId == USDC_USD || pairId == USDT_USD || pairId == AVAX_USD;
    }

    function _isSepoliaPairSupported(bytes32 pairId) private pure returns (bool) {
        return pairId == ETH_USD || pairId == BTC_USD || pairId == LINK_USD;
    }
}

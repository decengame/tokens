# Deploy script

```bash
$source .env
$forge create --legacy --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/DecenNFT.sol:DecenNFT
```

```bash
$forge flatten --output src/DecenNFT.flattened.sol src/DecenNFT.sol
```
function unlock(
  address _to,
  uint256 _amount,
  uint8[] _v,
  bytes32[] _r,
  bytes32[] _s
)
  external
{
  require(_v.length >= 5);
  bytes32 hashData = keccak256(_to, _amount);
  for (uint i = 0; i < _v.length; i++) {
    address recAddr = ecrecover(hashData, _v[i], _r[i], _s[i]);
    require(_isValidator(recAddr));
  }
  to.transfer(_amount);
}

# mitigation

public uint256 nonce;
function unlock(
  address _to,
  uint256 _amount, 
  uint256 _nonce,
  uint8[] _v,
  bytes32[] _r,
  bytes32[] _s
)
  external
{
  require(_v.length >= 5);
  require(_nonce == nonce++);
  bytes32 hashData = keccak256(_to, _amount, _nonce);
  for (uint i = 0; i < _v.length; i++) {
    address recAddr = ecrecover(hashData, _v[i], _r[i], _s[i]);
    require(_isValidator(recAddr));
  }
  to.transfer(_amount);
}

// @flow
export type NetworkTypes = 'ETH' | 'ETC' | 'POA' | 'Rinkeby' | 'Kovan' | 'Ropsten'

export interface NodeConfig {
  network: NetworkTypes,
  service: string,
  endpoint: string,
  estimateGas?: boolean,
  hidden?: boolean
}

export const NODES: { [key: string]: NodeConfig } = {
  eth_mew: {
    network: 'ETH',
    endpoint: 'https://api.myetherapi.com/eth',
    service: 'MyEtherWallet',
    estimateGas: true
  },
  eth_ethscan: {
    network: 'ETH',
    service: 'Etherscan.io',
    endpoint: 'https://api.etherscan.io/api',
    estimateGas: false
  },
  eth_infura: {
    network: 'ETH',
    service: 'infura.io',
    endpoint: 'https://mainnet.infura.io/mew',
    estimateGas: false
  },
  etc_epool: {
    network: 'ETC',
    service: 'Epool.io',
    endpoint: 'https://mewapi.epool.io',
    estimateGas: false
  },
  rop_mew: {
    network: 'Ropsten',
    service: 'MyEtherWallet',
    endpoint: 'https://api.myetherapi.com/rop',
    estimateGas: false
  },
  rop_infura: {
    network: 'Ropsten',
    service: 'infura.io',
    endpoint: 'https://ropsten.infura.io/mew',
    estimateGas: false
  },
  kov_ethscan: {
    network: 'Kovan',
    service: 'Etherscan.io',
    endpoint: 'https://kovan.etherscan.io/api',
    estimateGas: false
  },
  rin_ethscan: {
    network: 'Rinkeby',
    service: 'Etherscan.io',
    endpoint: 'https://rinkeby.etherscan.io/api',
    estimateGas: false
  },
  rin_infura: {
    network: 'Rinkeby',
    service: 'infura.io',
    endpoint: 'https://rinkeby.infura.io/mew',
    estimateGas: false
  }
}

export const NETWORK_NAMES : { [key: number] : string } = {
  [1]:      'Main Net',
  [2]:      'Deprecated Morden test network',
  [3]:      'Ropsten test network',
  [4]:      'Rinkeby test network',
  [42]:     'Kovan test network',
  [4447]:   'Truffle Develop Network',
  [5777]:   'Ganache Blockchain',
  [0xE0]:   'Maked Testrpc'
}

export const MUTATION_TYPES = {
  CHANGE_CURRENT_ROUTE_TO: 'changeCurrentRouteTo',
  REGISTER_WEB3_INSTANCE: 'registerWeb3Instance',
  UPDATE_USER_BLOCKCHAIN_STATUS: 'updateUserBlockchainStatus',
  UPDATE_WEB3_PROPERTIES: 'updateWeb3Properties',
  LOGIN: 'login',
  LOGOUT: 'logout'
}

export const ACTION_TYPES = MUTATION_TYPES

import * as fcl from '@onflow/fcl';

export function configureFCL() {

    fcl.config({
        'app.detail.title': 'STRAND',
        'app.detail.icon':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg',
        'fcl.limit': 9999,
    });

    if (import.meta.env.VITE_FLOW_ENV === 'emulator') {
        fcl.config({
            'accessNode.api': "http://127.0.0.1:8888",
            'discovery.wallet': "http://localhost:8701/fcl/authn",
            '0xMetadataViews': import.meta.env.VITE_EMULATOR_ACCOUNT,
            '0xNFTCatalog': import.meta.env.VITE_EMULATOR_ACCOUNT,
            '0xNFTRetrieval': import.meta.env.VITE_EMULATOR_ACCOUNT,
        });

    } else if (import.meta.env.VITE_FLOW_ENV === 'testnet') {
        fcl.config({
            'accessNode.api': "https://rest-testnet.onflow.org",
            'discovery.wallet': "https://fcl-discovery.onflow.org/testnet/authn",
            '0xMetadataViews': "0x631e88ae7f1d7c20",
            '0xNFTCatalog': "0x324c34e1c517e4db",
            '0xNFTRetrieval': "0x324c34e1c517e4db"
        });

    } 
    else {
        console.error("NO FCL CONFIG LOADED!!!")
    }

}

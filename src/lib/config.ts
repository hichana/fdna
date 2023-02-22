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
        });

    } else if (import.meta.env.VITE_FLOW_ENV === 'testnet') {
        fcl.config({
            'accessNode.api': "https://rest-testnet.onflow.org",
            'discovery.wallet': "https://fcl-discovery.onflow.org/testnet/authn",
        });

    } 
    else {
        console.error("NO FCL CONFIG LOADED!!!")
    }

}

import * as fcl from '@onflow/fcl';
import { configureFCL } from './config';
import { browser } from '$app/environment';
import { user } from './stores';

configureFCL();

if (browser) {
	// set Svelte $user store to currentUser, so other components can access it
	fcl.currentUser.subscribe(user.set, []);
}

// Lifecycle FCL Auth functions
export const unauthenticate = () => {
	fcl.unauthenticate();
};
export const logIn = async () => {
	await fcl.logIn();
};

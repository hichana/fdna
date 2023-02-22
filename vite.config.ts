import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import path from 'path';

export default defineConfig({
	plugins: [sveltekit()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	},
	resolve: {
		alias: {
			// isomorphic-fetch installed to mitigate error with svelte accessing emulator
			'node-fetch': 'isomorphic-fetch',
			'#lib': path.resolve('./src/lib'),
			'#lib/*': path.resolve('./src/lib/*'),
		}
	}
});

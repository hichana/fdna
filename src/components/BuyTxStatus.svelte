<script lang="ts">
	import { buyTxStatus } from '#lib/stores';
	import Spinner from './Spinner.svelte';
</script>

<div class="mx-4">
	{#if $buyTxStatus?.status === 0 || $buyTxStatus?.status === ''}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color={'text-phosgreen'} />
			<p>Your transaction is ready to be sent to a collector on the Flow blockhain.</p>
		</div>
	{:else if $buyTxStatus?.status === 1}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color={'text-phosgreen'} />
			<p>Your transaction has been received by a collector but not yet finalized in a block.</p>
		</div>
	{:else if $buyTxStatus?.status === 2}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color="text-phosgreen" animate="animate-bounce" />
			<p>Your transaction has been finalized in a block and awaiting execution.</p>
		</div>
	{:else if $buyTxStatus?.status === 3}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color="text-phosgreen" animate="animate-bounce" />
			<p>Your transaction has been finalized in a block and awaiting execution.</p>
		</div>
	{:else if $buyTxStatus?.status === 4}
		{#if $buyTxStatus?.statusCode === 0 && $buyTxStatus?.errorMessage === ''}
			<div
				class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6"
			>
				<Spinner color="text-phosgreen" animate="" />
				<p>Result has been committed to the Flow blockchain 🎉🎉🎉.</p>
			</div>
		{:else if $buyTxStatus?.statusCode === 1 && $buyTxStatus?.errorMessage !== ''}
			<div
				class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6"
			>
				<Spinner color={'text-red-500'} animate="" />
				<p>
					There's been an error, let us know in Discord: {$buyTxStatus?.errorMessage.slice(
						0,
						40
					)}...
				</p>
			</div>
		{/if}
	{:else if $buyTxStatus?.status === 5}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color={'text-red-500'} animate="" />
			<p>The transaction was submitted past its expiration block height.</p>
		</div>
	{:else if $buyTxStatus?.status === 99}
		<div class="mx-auto my-6 flex max-w-md justify-center rounded-xl border-2 border-slate-400 p-6">
			<Spinner color={'text-red-500'} animate="" />
			<p>Transaction Error</p>
		</div>
	{/if}
</div>

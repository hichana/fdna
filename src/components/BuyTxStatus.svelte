<script lang="ts">
	import { buyTxStatus } from '#lib/stores';
</script>

{#if $buyTxStatus?.status === 0}
	<p>Your transaction is ready to be sent to a collector on the Flow blockhain.</p>
{:else if $buyTxStatus?.status === 1}
	<p>Your transaction has been received by a collector but not yet finalized in a block.</p>
{:else if $buyTxStatus?.status === 2}
	<p>Your transaction has been finalized in a block and awaiting execution.</p>
{:else if $buyTxStatus?.status === 3}
	<p>Execution nodes have produced a result for the transaction.</p>
{:else if $buyTxStatus?.status === 4}
	{#if $buyTxStatus?.statusCode === 0 && $buyTxStatus?.errorMessage === ''}
		<p>Result has been committed to the Flow blockchain 🎉🎉🎉.</p>
	{:else if $buyTxStatus?.statusCode === 1 && $buyTxStatus?.errorMessage !== ''}
		<p>{$buyTxStatus?.errorMessage}</p>
	{/if}
{:else if $buyTxStatus?.status === 5}
	<p>The transaction was submitted past its expiration block height.</p>
{:else if $buyTxStatus?.status === 99}
	<p>Transaction Error</p>
{/if}

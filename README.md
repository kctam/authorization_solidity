# authorization_solidity

This is a demo code showing how to authorized a transaction by multiple parties before being executed.

Note that the address are hardcoded and this can be executed in Remix using built-in JavaScript VM.

# Demo Steps

Step 1: copy the code to Remix.

Step 2: Choose JavaScript VM as Environment, deploy the contract.

Step 3: use getValue and see the initial value is **Zero**.

Step 4: Keep ORG1 (0xca35...) call *proposalSetValue(100)*.

Step 5: Check *getProposal(1)*, and we will see the detail about the proposal and the approval status.

Step 6: ORG2 (0x1472...) and ORG3 (0x4b08...) *approve(1)*. use *getProposal(1) to get the latest approval status.

Step 7: After all three ORGs approve it, ORG1 (0xca35...) can *executeProposal(1), which will set the value finally (check *getValue()*.

Step 8: Repeat 4-7 and show that requirements are not met, for example,
- execute when some ORG has not approved yet.
- execute the proposal from another ORG.
- execute a proposal doesn't exist (a wrong index).
- execute by an address other than ORG1, ORG2 and ORG3.
- etc.

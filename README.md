# Decentralized Study Group Scheduler

The Decentralized Study Group Scheduler is a smart contract built on the Ethereum blockchain that allows students to propose, vote on, and confirm study group sessions. This decentralized approach ensures fairness and transparency in the scheduling process.

## Features

- **Propose a Study Session**: Users can propose new study sessions with a subject and date/time.
- **Vote on Sessions**: Users can vote on proposed sessions.
- **Confirm the Session**: Sessions are automatically confirmed once they receive enough votes.
- **Error Handling**: The contract uses Solidity's error handling mechanisms (`require()`, `assert()`, and `revert()`) to ensure valid operations.

## Prerequisites

- **Solidity Compiler**: Ensure you have a Solidity compiler version `^0.8.0`.
- **Ethereum Wallet**: An Ethereum wallet like MetaMask to deploy and interact with the contract.
- **ETH**: Some ETH to pay for gas fees during deployment and transactions.

## Contract Structure

### StudySession Struct
```solidity
struct StudySession {
    uint256 id;
    address proposer;
    string subject;
    string dateTime;
    uint256 votes;
    bool confirmed;
}
```

### State Variables
```solidity
address public owner;
uint256 public sessionCounter;
mapping(uint256 => StudySession) public studySessions;
mapping(uint256 => mapping(address => bool)) public votes; // sessionId => (voter => voted)
```

## Deployment

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-repo/study-group-scheduler.git
    cd study-group-scheduler
    ```

2. **Install dependencies** (if any):
    ```bash
    npm install
    ```

3. **Compile the contract**:
    Use Remix IDE or Truffle to compile the `StudyGroupScheduler.sol` contract.

4. **Deploy the contract**:
    - Open the compiled contract in Remix IDE.
    - Deploy the contract using MetaMask or another web3 provider.
    - Confirm the transaction in your Ethereum wallet.

## Interacting with the Contract

### Propose a Study Session
```solidity
function proposeSession(string memory _subject, string memory _dateTime) public
```
- **Inputs**:
  - `_subject`: The subject of the study session.
  - `_dateTime`: The date and time of the study session.
- **Output**: Emits `SessionProposed` event.

### Vote on a Session
```solidity
function voteSession(uint256 _id) public
```
- **Inputs**:
  - `_id`: The ID of the study session to vote on.
- **Output**: Emits `SessionVoted` event and `SessionConfirmed` event if enough votes are received.

### Confirm a Session (Owner only)
```solidity
function confirmSession(uint256 _id) public onlyOwner
```
- **Inputs**:
  - `_id`: The ID of the study session to confirm.
- **Output**: Emits `SessionConfirmed` event.

### Get Session Details
```solidity
function getSession(uint256 _id) public view returns (StudySession memory)
```
- **Inputs**:
  - `_id`: The ID of the study session to retrieve.
- **Output**: Returns the details of the specified study session.

## Error Handling

- **`require()`**: Validates input data and conditions (e.g., valid session ID, unique votes, session not already confirmed).
- **`assert()`**: Used for internal consistency checks (not explicitly used in this example, but can be added as needed).
- **`revert()`**: Implicitly used through `require()` to revert transactions if conditions are not met, ensuring atomicity and correctness of state changes.

## Events

- `SessionProposed(uint256 id, address proposer, string subject, string dateTime)`
- `SessionVoted(uint256 id, address voter)`
- `SessionConfirmed(uint256 id)`

## License

This project is licensed under the MIT License.

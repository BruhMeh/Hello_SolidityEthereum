pragma solidity ^0.4.18;

contract RegistroPessoa is Owner {
    //Atributo
    address[] public contas;
    mapping (address=>address) public mapaPessoas;

    event LogPessoaSalvaNoRegistro(address _contaResgistroPessoas, address _contaContratoPessoa);

    function salvaPessoas(address _contractAddress) public {
        contas.push(msg.sender);
        mapaPessoas[msg.sender] = _contractAddress;
        LogPessoaSalvaNoRegistro(_contractAddress, msg.sender);
    }
}
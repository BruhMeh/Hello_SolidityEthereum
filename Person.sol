pragma solidity ^0.4.16;

contract Owner {
    //atributos
    address public dono;
    modifier apenasDono() {
        require (msg.sender == dono);
        _;
    }

    function Owner() public {
        dono = msg.sender();
    }
}

contract RegistroPessoas {
    address[] public listaContaPessoas;
    mapping(address => address) mapaPessoas;
    uint public size;

    event LogPersonSalvaNoRegistro(address _contaPessoa, address _contaContratoPessoa, bool _inserido); 

    function salvaPessoas(address enderecoContratoPessoa) public returns(bool) {
        //mapaPessoas[msg.sender] == null (OBS: solidity não tem null toda variavel é setada com valor 0 por default)
        require(mapaPessoas[msg.sender] == 0x0);
         
        listaContaPessoas.push(msg.sender);
        mapaPessoas[msg.sender] = enderecoContratoPessoa;  
        size++;
        LogPersonSalvaNoRegistro(msg.sender, this, true);
    }

    function getTamanhoRegistro() public view returns(uint) {
        return listaContaPessoas.length;
    }
}

contract Destroyer is Owner {
    function kill() public apenasDono {
        selfdestruct(dono);
    }
}
contract Pessoa is Destroyer {
    string public nome;
    string public email;
    bool email_valido;
    uint cpf;
    uint dataNascimento;
    

    // criar lista de validadores
    address[] public listValidators;


    //int quantidadeValidos
    uint quantValid;
    //int quantidadeInvalidos
    uint quantInvalid;

    event LogPersonEmailAlterado(address _pessoa, string emailAlterado); 

    // criar método que retorne a quantidade de validadores

    //criar método que recebe um contrato de pessoa e o parametro se é valido ou não
    function validar(address personRegistryAddress, bool valid) {
        // verificar se o validador é diferent do dono do contrato
        require(msg.sender != dono);
        // verifica se o validador existe
        var enderecoPessoa = RegistroPessoas(personRegistryAddress).mapaPessoas;

       mapaPessoas[msg.sender]

        // adiciona na lista de validadores
        listValidators.push(msg.sender);

        //incrementa quantidadeValidos ou quantidadeInvalidos

    }

    function Pessoa(string _nome, string _email, int _cpf, uint _dataNascimento, address _enderecoRegistroPessoas) public {
        nome = _nome;
        email = _email;
        cpf = _cpf;
        dataNascimento = _dataNascimento;
        RegistroPessoas(_enderecoRegistroPessoas).salvaPessoas(this);
    }
    
    function mudarEmail(string _newMail) public apenasDono {
       email = _newMail;
       LogPersonEmailAlterado(msg.sender, _newMail);
    }
}
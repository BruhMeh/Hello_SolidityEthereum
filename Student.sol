pragma solidity ^0.4.16;

import {Destroyable} from "./Destroyable.sol";

contract Student is Destroyable {
    address enderecoContratoPessoa;
    Certificados[] public certificados;
    
    struct Certificados {
        address enderecoContratoProfessor;
        int8 codigoCurso;
        int8 qtdHoras;
        string nomeCurso;
    }

    function gerarCertificado(address enderecoProfessor, int codigoCurso, string nomeCurso, int8 qtdHoras) public {
        // instancio struct Certificados
        // seto informações
        // adiciono certificados
    }
    
    function Aluno(address _enderecoContratoPessoa) public {
        enderecoContratoPessoa = _enderecoContratoPessoa;
    }
    
    function inscricaoCurso(address _enderecoContratoProfessor, int _codigoCurso) {
        // instanciar o contrato e realizar a inscrição no curso
        
    }
    
    function enviarReputacaoCurso(address _enderecoContratoProfessor, int _codigoCurso, uint8 _reputacao, string _comentarios) {
        
    }
    
}
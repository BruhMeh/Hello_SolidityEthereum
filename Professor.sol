pragma solidity ^0.4.16;

import {Destroyable} from "./Destroyable.sol";
import {Person} from "./Person.sol";  
import {ProfessorInterface} from "./ProfessorInterface.sol";
import {Student} from "./Student.sol";

contract Professor is Destroyable, ProfessorInterface {
   address enderecoContratoProfessor;
    uint16 public score;
    string public descricao;
    address REGISTRO_PROFESSORES_ADDRESS;
    
    mapping(int => Curso) public listaCursos;

    event LogCursoGerado(int codigoCurso);

    struct Curso {
        int codigoCurso;
        int8 qtdPessoasLimite;
        string nomeCurso;
        string descricao;
        int8 qtdHoras;
        uint8 _score;        
        uint8[] votos;
        address[] enderecoContratoAluno;
        mapping(address => bool) mapaAlunos;
        mapping(uint8 => string) comentarios;
    }
    
    // function setContratoRegistroPessoas(address _registroProfessoresAddress) external onlyOwner {
    //     REGISTRO_PROFESSORES_ADDRESS = _registroProfessoresAddress;
    // }  
    
    function Professor(address _enderecoContratoProfessor, string _descricao) public {
        enderecoContratoProfessor = _enderecoContratoProfessor;
        descricao = _descricao;
        // RegistroProfessor(REGISTRO_PROFESSORES_ADDRESS).novoContratoProfessor()
    }

    function gerarInscricao(address enderecoContratoAluno, int codigoCurso) public {
        // require(listaCursos[codigoCurso]. != 0x0);
        Curso storage curso = listaCursos[codigoCurso];
        curso.enderecoContratoAluno.push(enderecoContratoAluno);
        // curso.mapaAlunos[enderecoContratoAluno] = false;
        listaCursos[codigoCurso] = curso;
    }
    
    function gerarCurso(int _codigoCurso, int8 _qtdPessoasLimite, string _nomeCurso, string _descricao, int8 _qtdHoras) public isOwner {
        uint8[] memory votos;
        address[] memory enderecoContratoAluno;

       listaCursos[_codigoCurso] = Curso ({
            codigoCurso: _codigoCurso,
            qtdPessoasLimite: _qtdPessoasLimite,
            nomeCurso: _nomeCurso,
            descricao: _descricao,
            qtdHoras: _qtdHoras,
            _score: 0,
            votos: votos,
            enderecoContratoAluno: enderecoContratoAluno
        });

    }

    function receberReputacao(address enderecoAluno, uint8 reputacao, int codigoCurso, string comentarios, bool receberCertificado) public {
        Curso storage curso = listaCursos[codigoCurso];
        require(curso.mapaAlunos[enderecoAluno]);

        // for (int i = 0; i < curso.enderecoContratoAluno().length; index++) {
            // if (curso.enderecoContratoAluno()[i] == enderecoAluno) {
        curso.comentarios[reputacao] = comentarios;
        listaCursos[codigoCurso] = curso;
        curso.votos.push(reputacao);
        
        if (receberCertificado) {
            Student student = Student(enderecoAluno);
            student.gerarCertificado(this, curso.codigoCurso, curso.nomeCurso, curso.qtdHoras);
        }
        curso.mapaAlunos[enderecoAluno] = true;
    }

}
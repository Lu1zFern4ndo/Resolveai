import '../models/categoria_servico.dart';
import '../models/prestador.dart';

const double kLatTeresina = -5.0892;
const double kLngTeresina = -42.8019;

const List<Prestador> prestadoresMock = [
  Prestador(
    id: 'p1',
    nome: 'João Silva',
    telefone: '(86) 99999-0001',
    categoria: CategoriaServico.encanador,
    lat: -5.0850,
    lng: -42.8000,
    avaliacao: 4.8,
  ),
  Prestador(
    id: 'p2',
    nome: 'Maria Souza',
    telefone: '(86) 99999-0002',
    categoria: CategoriaServico.eletricista,
    lat: -5.0950,
    lng: -42.8100,
    avaliacao: 4.5,
  ),
  Prestador(
    id: 'p3',
    nome: 'Carlos Pereira',
    telefone: '(86) 99999-0003',
    categoria: CategoriaServico.pedreiro,
    lat: -5.0700,
    lng: -42.7900,
    avaliacao: 4.2,
  ),
  Prestador(
    id: 'p4',
    nome: 'Ana Lima',
    telefone: '(86) 99999-0004',
    categoria: CategoriaServico.pintor,
    lat: -5.1100,
    lng: -42.7800,
    avaliacao: 4.9,
  ),
  Prestador(
    id: 'p5',
    nome: 'Pedro Costa',
    telefone: '(86) 99999-0005',
    categoria: CategoriaServico.tecnicoEletro,
    lat: -5.0600,
    lng: -42.8300,
    avaliacao: 3.9,
  ),
  Prestador(
    id: 'p6',
    nome: 'Luciana Rocha',
    telefone: '(86) 99999-0006',
    categoria: CategoriaServico.eletricista,
    lat: -5.1500,
    lng: -42.7500,
    avaliacao: 4.6,
  ),
  Prestador(
    id: 'p7',
    nome: 'Rafael Alves',
    telefone: '(86) 99999-0007',
    categoria: CategoriaServico.encanador,
    lat: -5.2200,
    lng: -42.7000,
    avaliacao: 4.0,
  ),
];
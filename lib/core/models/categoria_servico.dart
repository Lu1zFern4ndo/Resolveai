enum CategoriaServico {
  encanador('Encanador'),
  eletricista('Eletricista'),
  pedreiro('Pedreiro'),
  pintor('Pintor'),
  tecnicoEletro('Técnico de eletrodomésticos'),
  outros('Outros');

  final String nome;
  const CategoriaServico(this.nome);

  static CategoriaServico fromName(String? name) => CategoriaServico.values
      .firstWhere((c) => c.name == name, orElse: () => CategoriaServico.outros);
}
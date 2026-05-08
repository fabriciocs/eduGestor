// Arquivo gerado.
const moduleCatalog = [
  {
    "name": "Avaliações, notas e boletins",
    "requirements": 6,
    "entities": 5,
    "must": 3
  },
  {
    "name": "BI, dashboards e relatórios",
    "requirements": 7,
    "entities": 4,
    "must": 4
  },
  {
    "name": "CRM e captação",
    "requirements": 4,
    "entities": 4,
    "must": 0
  },
  {
    "name": "Cadastros centrais",
    "requirements": 9,
    "entities": 8,
    "must": 8
  },
  {
    "name": "Compliance, privacidade e governança",
    "requirements": 6,
    "entities": 6,
    "must": 3
  },
  {
    "name": "Comunicação e relacionamento",
    "requirements": 9,
    "entities": 7,
    "must": 2
  },
  {
    "name": "Cursos livres, idiomas e técnicos",
    "requirements": 5,
    "entities": 3,
    "must": 0
  },
  {
    "name": "Educação infantil",
    "requirements": 5,
    "entities": 3,
    "must": 0
  },
  {
    "name": "Financeiro",
    "requirements": 12,
    "entities": 12,
    "must": 7
  },
  {
    "name": "Frequência",
    "requirements": 6,
    "entities": 3,
    "must": 4
  },
  {
    "name": "Gestão acadêmica",
    "requirements": 8,
    "entities": 13,
    "must": 5
  },
  {
    "name": "IA e automação inteligente",
    "requirements": 5,
    "entities": 2,
    "must": 0
  },
  {
    "name": "Integrações e automações",
    "requirements": 6,
    "entities": 3,
    "must": 1
  },
  {
    "name": "Matrícula, rematrícula e secretaria digital",
    "requirements": 10,
    "entities": 7,
    "must": 6
  },
  {
    "name": "Multiunidade e redes",
    "requirements": 4,
    "entities": 0,
    "must": 1
  },
  {
    "name": "Onboarding, implantação e importação",
    "requirements": 6,
    "entities": 3,
    "must": 5
  },
  {
    "name": "Plataforma, tenant e configuração",
    "requirements": 6,
    "entities": 5,
    "must": 4
  },
  {
    "name": "Portal do professor",
    "requirements": 6,
    "entities": 4,
    "must": 4
  },
  {
    "name": "Portal do responsável e aluno",
    "requirements": 8,
    "entities": 0,
    "must": 4
  },
  {
    "name": "Usuários, perfis e permissões",
    "requirements": 6,
    "entities": 6,
    "must": 5
  }
];
const entityCatalog = [
  {
    "table": "tenant",
    "name": "Tenant",
    "module": "Plataforma, tenant e configuração",
    "description": "Instituição contratante/ambiente lógico multi-tenant."
  },
  {
    "table": "mantenedora",
    "name": "Mantenedora",
    "module": "Plataforma, tenant e configuração",
    "description": "Pessoa jurídica mantenedora da escola/rede."
  },
  {
    "table": "unidade_escolar",
    "name": "UnidadeEscolar",
    "module": "Plataforma, tenant e configuração",
    "description": "Unidade física ou operacional vinculada ao tenant."
  },
  {
    "table": "parametro_sistema",
    "name": "ParametroSistema",
    "module": "Plataforma, tenant e configuração",
    "description": "Parâmetros globais e por tenant."
  },
  {
    "table": "canal_oficial",
    "name": "CanalOficial",
    "module": "Plataforma, tenant e configuração",
    "description": "Canais oficiais de atendimento/comunicação."
  },
  {
    "table": "ano_letivo",
    "name": "AnoLetivo",
    "module": "Gestão acadêmica",
    "description": "Ano/estrutura de calendário acadêmico."
  },
  {
    "table": "periodo_letivo",
    "name": "PeriodoLetivo",
    "module": "Gestão acadêmica",
    "description": "Bimestre, trimestre, semestre ou etapa letiva."
  },
  {
    "table": "turno",
    "name": "Turno",
    "module": "Gestão acadêmica",
    "description": "Turnos operacionais."
  },
  {
    "table": "calendario_escolar",
    "name": "CalendarioEscolar",
    "module": "Gestão acadêmica",
    "description": "Calendário letivo e eventos."
  },
  {
    "table": "evento_calendario",
    "name": "EventoCalendario",
    "module": "Gestão acadêmica",
    "description": "Feriados, recessos, reuniões e eventos."
  },
  {
    "table": "curso",
    "name": "Curso",
    "module": "Gestão acadêmica",
    "description": "Curso, segmento, programa ou formação."
  },
  {
    "table": "serie_etapa",
    "name": "SerieEtapa",
    "module": "Gestão acadêmica",
    "description": "Série, ano, módulo ou etapa."
  },
  {
    "table": "grade_curricular",
    "name": "GradeCurricular",
    "module": "Gestão acadêmica",
    "description": "Composição curricular por curso/série."
  },
  {
    "table": "disciplina",
    "name": "Disciplina",
    "module": "Gestão acadêmica",
    "description": "Componente curricular."
  },
  {
    "table": "turma",
    "name": "Turma",
    "module": "Gestão acadêmica",
    "description": "Turma/oferta vinculada a série, turno e ano letivo."
  },
  {
    "table": "turma_disciplina",
    "name": "TurmaDisciplina",
    "module": "Gestão acadêmica",
    "description": "Oferta de disciplina em turma."
  },
  {
    "table": "professor",
    "name": "Professor",
    "module": "Portal do professor",
    "description": "Docente e seus vínculos."
  },
  {
    "table": "professor_disciplina",
    "name": "ProfessorDisciplina",
    "module": "Portal do professor",
    "description": "Habilitação/vínculo docente-disciplina."
  },
  {
    "table": "horario_aula",
    "name": "HorarioAula",
    "module": "Gestão acadêmica",
    "description": "Quadro de horários."
  },
  {
    "table": "sala_ambiente",
    "name": "SalaAmbiente",
    "module": "Gestão acadêmica",
    "description": "Salas físicas/virtuais."
  },
  {
    "table": "aluno",
    "name": "Aluno",
    "module": "Cadastros centrais",
    "description": "Pessoa discente."
  },
  {
    "table": "responsavel",
    "name": "Responsavel",
    "module": "Cadastros centrais",
    "description": "Responsável legal/financeiro/pedagógico."
  },
  {
    "table": "aluno_responsavel",
    "name": "AlunoResponsavel",
    "module": "Cadastros centrais",
    "description": "Vínculo aluno-responsável."
  },
  {
    "table": "endereco",
    "name": "Endereco",
    "module": "Cadastros centrais",
    "description": "Endereços de pessoas/unidades."
  },
  {
    "table": "contato",
    "name": "Contato",
    "module": "Cadastros centrais",
    "description": "Telefones, e-mails e contatos."
  },
  {
    "table": "documento_pessoa",
    "name": "DocumentoPessoa",
    "module": "Cadastros centrais",
    "description": "Documentos civis e escolares."
  },
  {
    "table": "necessidade_especial",
    "name": "NecessidadeEspecial",
    "module": "Cadastros centrais",
    "description": "Necessidades e restrições de atendimento."
  },
  {
    "table": "ficha_saude",
    "name": "FichaSaude",
    "module": "Cadastros centrais",
    "description": "Informações de saúde e emergência."
  },
  {
    "table": "matricula",
    "name": "Matricula",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Vínculo acadêmico do aluno."
  },
  {
    "table": "processo_matricula",
    "name": "ProcessoMatricula",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Fluxo de matrícula/rematrícula."
  },
  {
    "table": "contrato_educacional",
    "name": "ContratoEducacional",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Contrato de prestação de serviços educacionais."
  },
  {
    "table": "documento_escolar",
    "name": "DocumentoEscolar",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Declarações, histórico, comprovantes."
  },
  {
    "table": "assinatura_digital",
    "name": "AssinaturaDigital",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Assinaturas eletrônicas/digitais."
  },
  {
    "table": "solicitacao_secretaria",
    "name": "SolicitacaoSecretaria",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Pedidos feitos à secretaria."
  },
  {
    "table": "vaga_oferta",
    "name": "VagaOferta",
    "module": "Matrícula, rematrícula e secretaria digital",
    "description": "Vagas por curso/série/turma."
  },
  {
    "table": "lista_espera",
    "name": "ListaEspera",
    "module": "CRM e captação",
    "description": "Candidatos em espera."
  },
  {
    "table": "lead_prospect",
    "name": "LeadProspect",
    "module": "CRM e captação",
    "description": "Interessados/candidatos."
  },
  {
    "table": "atendimento_lead",
    "name": "AtendimentoLead",
    "module": "CRM e captação",
    "description": "Interações comerciais."
  },
  {
    "table": "campanha_captacao",
    "name": "CampanhaCaptacao",
    "module": "CRM e captação",
    "description": "Campanhas de captação."
  },
  {
    "table": "frequencia_aula",
    "name": "FrequenciaAula",
    "module": "Frequência",
    "description": "Registro de chamada por aula/data."
  },
  {
    "table": "frequencia_aluno",
    "name": "FrequenciaAluno",
    "module": "Frequência",
    "description": "Presença/ausência por aluno."
  },
  {
    "table": "justificativa_falta",
    "name": "JustificativaFalta",
    "module": "Frequência",
    "description": "Justificativa de ausência."
  },
  {
    "table": "ocorrencia_pedagogica",
    "name": "OcorrenciaPedagogica",
    "module": "Portal do professor",
    "description": "Ocorrências e observações."
  },
  {
    "table": "conteudo_aula",
    "name": "ConteudoAula",
    "module": "Portal do professor",
    "description": "Conteúdo ministrado e planejamento."
  },
  {
    "table": "avaliacao",
    "name": "Avaliacao",
    "module": "Avaliações, notas e boletins",
    "description": "Instrumento avaliativo."
  },
  {
    "table": "nota_aluno",
    "name": "NotaAluno",
    "module": "Avaliações, notas e boletins",
    "description": "Resultado avaliativo do aluno."
  },
  {
    "table": "formula_avaliacao",
    "name": "FormulaAvaliacao",
    "module": "Avaliações, notas e boletins",
    "description": "Regras de cálculo de médias."
  },
  {
    "table": "boletim",
    "name": "Boletim",
    "module": "Avaliações, notas e boletins",
    "description": "Consolidação de notas/frequência."
  },
  {
    "table": "historico_academico",
    "name": "HistoricoAcademico",
    "module": "Avaliações, notas e boletins",
    "description": "Histórico escolar consolidado."
  },
  {
    "table": "plano_financeiro",
    "name": "PlanoFinanceiro",
    "module": "Financeiro",
    "description": "Tabela de preços e planos."
  },
  {
    "table": "conta_receber",
    "name": "ContaReceber",
    "module": "Financeiro",
    "description": "Mensalidades e cobranças."
  },
  {
    "table": "parcela_cobranca",
    "name": "ParcelaCobranca",
    "module": "Financeiro",
    "description": "Parcelas financeiras."
  },
  {
    "table": "boleto",
    "name": "Boleto",
    "module": "Financeiro",
    "description": "Boletos/linhas digitáveis."
  },
  {
    "table": "pagamento",
    "name": "Pagamento",
    "module": "Financeiro",
    "description": "Pagamentos recebidos."
  },
  {
    "table": "baixa_financeira",
    "name": "BaixaFinanceira",
    "module": "Financeiro",
    "description": "Baixa manual/automática."
  },
  {
    "table": "inadimplencia",
    "name": "Inadimplencia",
    "module": "Financeiro",
    "description": "Controle de atrasos."
  },
  {
    "table": "renegociacao",
    "name": "Renegociacao",
    "module": "Financeiro",
    "description": "Acordos financeiros."
  },
  {
    "table": "desconto_bolsa",
    "name": "DescontoBolsa",
    "module": "Financeiro",
    "description": "Bolsas e descontos."
  },
  {
    "table": "conta_contabil_categoria",
    "name": "ContaContabilCategoria",
    "module": "Financeiro",
    "description": "Categorias financeiras/contábeis."
  },
  {
    "table": "nota_fiscal_servico",
    "name": "NotaFiscalServico",
    "module": "Financeiro",
    "description": "Nota fiscal de serviços educacionais, se aplicável."
  },
  {
    "table": "configuracao_fiscal",
    "name": "ConfiguracaoFiscal",
    "module": "Financeiro",
    "description": "Parâmetros fiscais municipais/tributários."
  },
  {
    "table": "comunicado",
    "name": "Comunicado",
    "module": "Comunicação e relacionamento",
    "description": "Comunicados enviados."
  },
  {
    "table": "mensagem",
    "name": "Mensagem",
    "module": "Comunicação e relacionamento",
    "description": "Mensagens individuais ou por conversa."
  },
  {
    "table": "conversa",
    "name": "Conversa",
    "module": "Comunicação e relacionamento",
    "description": "Thread/canal de atendimento."
  },
  {
    "table": "destinatario_comunicacao",
    "name": "DestinatarioComunicacao",
    "module": "Comunicação e relacionamento",
    "description": "Público-alvo de comunicação."
  },
  {
    "table": "confirmacao_leitura",
    "name": "ConfirmacaoLeitura",
    "module": "Comunicação e relacionamento",
    "description": "Leitura/entrega/ciência."
  },
  {
    "table": "template_mensagem",
    "name": "TemplateMensagem",
    "module": "Comunicação e relacionamento",
    "description": "Modelos de mensagem."
  },
  {
    "table": "preferencia_comunicacao",
    "name": "PreferenciaComunicacao",
    "module": "Comunicação e relacionamento",
    "description": "Preferências e consentimentos de canal."
  },
  {
    "table": "usuario",
    "name": "Usuario",
    "module": "Usuários, perfis e permissões",
    "description": "Conta de acesso."
  },
  {
    "table": "perfil_acesso",
    "name": "PerfilAcesso",
    "module": "Usuários, perfis e permissões",
    "description": "Perfil/RBAC."
  },
  {
    "table": "permissao",
    "name": "Permissao",
    "module": "Usuários, perfis e permissões",
    "description": "Permissões granulares."
  },
  {
    "table": "usuario_perfil",
    "name": "UsuarioPerfil",
    "module": "Usuários, perfis e permissões",
    "description": "Vínculo usuário-perfil."
  },
  {
    "table": "sessao_usuario",
    "name": "SessaoUsuario",
    "module": "Usuários, perfis e permissões",
    "description": "Sessões e tokens."
  },
  {
    "table": "convite_usuario",
    "name": "ConviteUsuario",
    "module": "Usuários, perfis e permissões",
    "description": "Convites e ativação de acesso."
  },
  {
    "table": "termo_consentimento",
    "name": "TermoConsentimento",
    "module": "Compliance, privacidade e governança",
    "description": "Termos, consentimentos e bases legais."
  },
  {
    "table": "registro_consentimento",
    "name": "RegistroConsentimento",
    "module": "Compliance, privacidade e governança",
    "description": "Aceites/recusas por titular/responsável."
  },
  {
    "table": "solicitacao_titular_lgpd",
    "name": "SolicitacaoTitularLGPD",
    "module": "Compliance, privacidade e governança",
    "description": "Direitos do titular."
  },
  {
    "table": "inventario_dados",
    "name": "InventarioDados",
    "module": "Compliance, privacidade e governança",
    "description": "Inventário de dados e finalidade."
  },
  {
    "table": "log_auditoria",
    "name": "LogAuditoria",
    "module": "Compliance, privacidade e governança",
    "description": "Trilha de auditoria."
  },
  {
    "table": "exportacao_dados",
    "name": "ExportacaoDados",
    "module": "Compliance, privacidade e governança",
    "description": "Exportações e relatórios."
  },
  {
    "table": "integracao_externa",
    "name": "IntegracaoExterna",
    "module": "Integrações e automações",
    "description": "Cadastro de integrações."
  },
  {
    "table": "evento_integracao",
    "name": "EventoIntegracao",
    "module": "Integrações e automações",
    "description": "Webhook/fila/evento."
  },
  {
    "table": "credencial_integracao",
    "name": "CredencialIntegracao",
    "module": "Integrações e automações",
    "description": "Credenciais/tokenização."
  },
  {
    "table": "importacao_dados",
    "name": "ImportacaoDados",
    "module": "Onboarding, implantação e importação",
    "description": "Lotes de importação."
  },
  {
    "table": "erro_importacao",
    "name": "ErroImportacao",
    "module": "Onboarding, implantação e importação",
    "description": "Erros por linha/campo."
  },
  {
    "table": "tarefa_implantacao",
    "name": "TarefaImplantacao",
    "module": "Onboarding, implantação e importação",
    "description": "Checklist de implantação."
  },
  {
    "table": "relatorio",
    "name": "Relatorio",
    "module": "BI, dashboards e relatórios",
    "description": "Relatórios configurados."
  },
  {
    "table": "dashboard",
    "name": "Dashboard",
    "module": "BI, dashboards e relatórios",
    "description": "Painéis gerenciais."
  },
  {
    "table": "indicador_kpi",
    "name": "IndicadorKPI",
    "module": "BI, dashboards e relatórios",
    "description": "Indicadores calculados."
  },
  {
    "table": "snapshot_indicador",
    "name": "SnapshotIndicador",
    "module": "BI, dashboards e relatórios",
    "description": "Histórico de indicadores."
  },
  {
    "table": "curso_livre_oferta",
    "name": "CursoLivreOferta",
    "module": "Cursos livres, idiomas e técnicos",
    "description": "Ofertas flexíveis de curso livre/técnico."
  },
  {
    "table": "modulo_curso",
    "name": "ModuloCurso",
    "module": "Cursos livres, idiomas e técnicos",
    "description": "Módulos de cursos técnicos/livres."
  },
  {
    "table": "certificado",
    "name": "Certificado",
    "module": "Cursos livres, idiomas e técnicos",
    "description": "Certificados emitidos."
  },
  {
    "table": "diario_infantil",
    "name": "DiarioInfantil",
    "module": "Educação infantil",
    "description": "Diário de rotina infantil."
  },
  {
    "table": "rotina_infantil",
    "name": "RotinaInfantil",
    "module": "Educação infantil",
    "description": "Sono, alimentação, higiene."
  },
  {
    "table": "autorizacao_retirada",
    "name": "AutorizacaoRetirada",
    "module": "Educação infantil",
    "description": "Pessoas autorizadas a retirar aluno."
  },
  {
    "table": "alerta_assistivo_ia",
    "name": "AlertaAssistivoIA",
    "module": "IA e automação inteligente",
    "description": "Alertas explicáveis e revisáveis."
  },
  {
    "table": "modelo_predicao_ia",
    "name": "ModeloPredicaoIA",
    "module": "IA e automação inteligente",
    "description": "Configuração/versionamento de modelo."
  }
];
const requirementCatalog = [
  {
    "id": "RF-001",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir cadastro de instituição mantenedora.",
    "priority": "Must"
  },
  {
    "id": "RF-002",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir cadastro de unidades vinculadas à instituição.",
    "priority": "Must"
  },
  {
    "id": "RF-003",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir configuração de ano letivo, períodos, turnos e calendário.",
    "priority": "Must"
  },
  {
    "id": "RF-004",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir personalização básica de nome, logotipo e canais oficiais da escola.",
    "priority": "Should"
  },
  {
    "id": "RF-005",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir ativar, suspender ou inativar unidade.",
    "priority": "Should"
  },
  {
    "id": "RF-006",
    "module": "Plataforma, tenant e configuração",
    "title": "Permitir parametrização de segmentos educacionais por unidade.",
    "priority": "Must"
  },
  {
    "id": "RF-007",
    "module": "Usuários, perfis e permissões",
    "title": "Permitir cadastro de usuários internos.",
    "priority": "Must"
  },
  {
    "id": "RF-008",
    "module": "Usuários, perfis e permissões",
    "title": "Permitir associação de usuário a perfil.",
    "priority": "Must"
  },
  {
    "id": "RF-009",
    "module": "Usuários, perfis e permissões",
    "title": "Permitir perfis padrão: mantenedor, direção, secretaria, financeiro, coordenação, professor e suporte.",
    "priority": "Must"
  },
  {
    "id": "RF-010",
    "module": "Usuários, perfis e permissões",
    "title": "Permitir configuração granular de permissões por módulo e ação.",
    "priority": "Should"
  },
  {
    "id": "RF-011",
    "module": "Usuários, perfis e permissões",
    "title": "Permitir restrição por unidade, turma ou vínculo.",
    "priority": "Must"
  },
  {
    "id": "RF-012",
    "module": "Usuários, perfis e permissões",
    "title": "Registrar logs de acesso e ações sensíveis.",
    "priority": "Must"
  },
  {
    "id": "RF-013",
    "module": "Onboarding, implantação e importação",
    "title": "Exibir checklist de implantação inicial.",
    "priority": "Must"
  },
  {
    "id": "RF-014",
    "module": "Onboarding, implantação e importação",
    "title": "Permitir importação de alunos por planilha.",
    "priority": "Must"
  },
  {
    "id": "RF-015",
    "module": "Onboarding, implantação e importação",
    "title": "Permitir importação de responsáveis por planilha.",
    "priority": "Must"
  },
  {
    "id": "RF-016",
    "module": "Onboarding, implantação e importação",
    "title": "Permitir importação de professores e turmas.",
    "priority": "Should"
  },
  {
    "id": "RF-017",
    "module": "Onboarding, implantação e importação",
    "title": "Validar dados duplicados, incompletos ou inconsistentes na importação.",
    "priority": "Must"
  },
  {
    "id": "RF-018",
    "module": "Onboarding, implantação e importação",
    "title": "Permitir exportação de dados operacionais autorizados.",
    "priority": "Must"
  },
  {
    "id": "RF-019",
    "module": "Cadastros centrais",
    "title": "Permitir cadastrar aluno.",
    "priority": "Must"
  },
  {
    "id": "RF-020",
    "module": "Cadastros centrais",
    "title": "Permitir editar dados cadastrais do aluno.",
    "priority": "Must"
  },
  {
    "id": "RF-021",
    "module": "Cadastros centrais",
    "title": "Permitir inativar aluno sem apagar histórico.",
    "priority": "Must"
  },
  {
    "id": "RF-022",
    "module": "Cadastros centrais",
    "title": "Permitir cadastrar responsáveis.",
    "priority": "Must"
  },
  {
    "id": "RF-023",
    "module": "Cadastros centrais",
    "title": "Permitir vincular múltiplos responsáveis a um aluno.",
    "priority": "Must"
  },
  {
    "id": "RF-024",
    "module": "Cadastros centrais",
    "title": "Permitir definir responsável financeiro e pedagógico.",
    "priority": "Must"
  },
  {
    "id": "RF-025",
    "module": "Cadastros centrais",
    "title": "Permitir cadastrar professores.",
    "priority": "Must"
  },
  {
    "id": "RF-026",
    "module": "Cadastros centrais",
    "title": "Permitir cadastrar colaboradores administrativos.",
    "priority": "Should"
  },
  {
    "id": "RF-027",
    "module": "Cadastros centrais",
    "title": "Permitir busca e filtros por nome, status, turma, unidade e segmento.",
    "priority": "Must"
  },
  {
    "id": "RF-028",
    "module": "CRM e captação",
    "title": "Permitir cadastro de leads interessados.",
    "priority": "Could"
  },
  {
    "id": "RF-029",
    "module": "CRM e captação",
    "title": "Permitir registrar origem, interesse, série/curso e responsável do lead.",
    "priority": "Could"
  },
  {
    "id": "RF-030",
    "module": "CRM e captação",
    "title": "Permitir converter lead em aluno/matrícula.",
    "priority": "Could"
  },
  {
    "id": "RF-031",
    "module": "CRM e captação",
    "title": "Permitir campanhas de rematrícula.",
    "priority": "Should"
  },
  {
    "id": "RF-032",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir criar matrícula de aluno em curso/série/turma/ano letivo.",
    "priority": "Must"
  },
  {
    "id": "RF-033",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Verificar disponibilidade de vaga antes da confirmação.",
    "priority": "Must"
  },
  {
    "id": "RF-034",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir rematrícula para novo período letivo.",
    "priority": "Must"
  },
  {
    "id": "RF-035",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir checklist documental por segmento.",
    "priority": "Must"
  },
  {
    "id": "RF-036",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir upload e controle de documentos do aluno/responsável.",
    "priority": "Must"
  },
  {
    "id": "RF-037",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir marcar documento como pendente, recebido, aprovado ou rejeitado.",
    "priority": "Must"
  },
  {
    "id": "RF-038",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir emissão de declaração simples e comprovante de matrícula.",
    "priority": "Should"
  },
  {
    "id": "RF-039",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir gerar boletim básico.",
    "priority": "Should"
  },
  {
    "id": "RF-040",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir lista de espera por turma.",
    "priority": "Should"
  },
  {
    "id": "RF-041",
    "module": "Matrícula, rematrícula e secretaria digital",
    "title": "Permitir cancelamento, transferência ou trancamento com motivo.",
    "priority": "Should"
  },
  {
    "id": "RF-042",
    "module": "Gestão acadêmica",
    "title": "Permitir cadastrar cursos, séries, etapas ou módulos.",
    "priority": "Must"
  },
  {
    "id": "RF-043",
    "module": "Gestão acadêmica",
    "title": "Permitir cadastrar disciplinas/componentes curriculares.",
    "priority": "Must"
  },
  {
    "id": "RF-044",
    "module": "Gestão acadêmica",
    "title": "Permitir cadastrar turmas com ano, turno, capacidade e unidade.",
    "priority": "Must"
  },
  {
    "id": "RF-045",
    "module": "Gestão acadêmica",
    "title": "Permitir vincular professores a turmas e disciplinas.",
    "priority": "Must"
  },
  {
    "id": "RF-046",
    "module": "Gestão acadêmica",
    "title": "Permitir configurar calendário escolar e eventos.",
    "priority": "Must"
  },
  {
    "id": "RF-047",
    "module": "Gestão acadêmica",
    "title": "Permitir registro de conteúdo/aula no diário.",
    "priority": "Should"
  },
  {
    "id": "RF-048",
    "module": "Gestão acadêmica",
    "title": "Permitir registro de ocorrências pedagógicas.",
    "priority": "Should"
  },
  {
    "id": "RF-049",
    "module": "Gestão acadêmica",
    "title": "Permitir controle de carga horária por disciplina/turma.",
    "priority": "Should"
  },
  {
    "id": "RF-050",
    "module": "Frequência",
    "title": "Permitir chamada por turma e data.",
    "priority": "Must"
  },
  {
    "id": "RF-051",
    "module": "Frequência",
    "title": "Permitir marcar presença, falta, atraso ou justificativa.",
    "priority": "Must"
  },
  {
    "id": "RF-052",
    "module": "Frequência",
    "title": "Permitir edição de frequência com justificativa.",
    "priority": "Should"
  },
  {
    "id": "RF-053",
    "module": "Frequência",
    "title": "Exibir pendências de chamada para professor e coordenação.",
    "priority": "Must"
  },
  {
    "id": "RF-054",
    "module": "Frequência",
    "title": "Gerar relatório de frequência por aluno, turma e período.",
    "priority": "Must"
  },
  {
    "id": "RF-055",
    "module": "Frequência",
    "title": "Permitir alerta de baixa frequência conforme parâmetro.",
    "priority": "Should"
  },
  {
    "id": "RF-056",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir configurar períodos avaliativos.",
    "priority": "Must"
  },
  {
    "id": "RF-057",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir cadastrar avaliações por turma/disciplina.",
    "priority": "Must"
  },
  {
    "id": "RF-058",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir lançamento de notas ou conceitos.",
    "priority": "Must"
  },
  {
    "id": "RF-059",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir cálculo de média conforme regra parametrizada.",
    "priority": "Should"
  },
  {
    "id": "RF-060",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir revisão/liberação de boletim pela coordenação.",
    "priority": "Should"
  },
  {
    "id": "RF-061",
    "module": "Avaliações, notas e boletins",
    "title": "Permitir registro de recuperação.",
    "priority": "Could"
  },
  {
    "id": "RF-062",
    "module": "Educação infantil",
    "title": "Permitir agenda diária da criança.",
    "priority": "Could"
  },
  {
    "id": "RF-063",
    "module": "Educação infantil",
    "title": "Permitir registrar alimentação, sono, banheiro/fraldas e humor.",
    "priority": "Could"
  },
  {
    "id": "RF-064",
    "module": "Educação infantil",
    "title": "Permitir registrar medicamentos com autorização.",
    "priority": "Could"
  },
  {
    "id": "RF-065",
    "module": "Educação infantil",
    "title": "Permitir autorização de retirada por pessoa autorizada.",
    "priority": "Should"
  },
  {
    "id": "RF-066",
    "module": "Educação infantil",
    "title": "Permitir fotos e registros com controle de consentimento.",
    "priority": "Could"
  },
  {
    "id": "RF-067",
    "module": "Cursos livres, idiomas e técnicos",
    "title": "Permitir matrícula por pacote, módulo, turma ou assinatura.",
    "priority": "Should"
  },
  {
    "id": "RF-068",
    "module": "Cursos livres, idiomas e técnicos",
    "title": "Permitir controle de reposição de aula.",
    "priority": "Should"
  },
  {
    "id": "RF-069",
    "module": "Cursos livres, idiomas e técnicos",
    "title": "Permitir avaliação por nível.",
    "priority": "Could"
  },
  {
    "id": "RF-070",
    "module": "Cursos livres, idiomas e técnicos",
    "title": "Permitir certificado por conclusão/carga horária.",
    "priority": "Could"
  },
  {
    "id": "RF-071",
    "module": "Cursos livres, idiomas e técnicos",
    "title": "Permitir controle de estágio/atividade prática para técnicos.",
    "priority": "Could"
  },
  {
    "id": "RF-072",
    "module": "Financeiro",
    "title": "Permitir configurar planos financeiros.",
    "priority": "Must"
  },
  {
    "id": "RF-073",
    "module": "Financeiro",
    "title": "Permitir geração de mensalidades a partir da matrícula.",
    "priority": "Must"
  },
  {
    "id": "RF-074",
    "module": "Financeiro",
    "title": "Permitir lançamento de taxas de matrícula/rematrícula e materiais.",
    "priority": "Should"
  },
  {
    "id": "RF-075",
    "module": "Financeiro",
    "title": "Permitir registro manual de pagamento.",
    "priority": "Must"
  },
  {
    "id": "RF-076",
    "module": "Financeiro",
    "title": "Permitir descontos, bolsas, multas e juros.",
    "priority": "Must"
  },
  {
    "id": "RF-077",
    "module": "Financeiro",
    "title": "Permitir controle de inadimplência.",
    "priority": "Must"
  },
  {
    "id": "RF-078",
    "module": "Financeiro",
    "title": "Permitir acordos e renegociação de dívida.",
    "priority": "Should"
  },
  {
    "id": "RF-079",
    "module": "Financeiro",
    "title": "Permitir emissão de recibo.",
    "priority": "Should"
  },
  {
    "id": "RF-080",
    "module": "Financeiro",
    "title": "Permitir relatório de recebíveis.",
    "priority": "Must"
  },
  {
    "id": "RF-081",
    "module": "Financeiro",
    "title": "Permitir previsão de receita.",
    "priority": "Should"
  },
  {
    "id": "RF-082",
    "module": "Financeiro",
    "title": "Permitir exportação financeira autorizada.",
    "priority": "Must"
  },
  {
    "id": "RF-083",
    "module": "Financeiro",
    "title": "Permitir conciliação financeira por integração ou arquivo em fase futura.",
    "priority": "Could"
  },
  {
    "id": "RF-084",
    "module": "Comunicação e relacionamento",
    "title": "Permitir criação de comunicados.",
    "priority": "Must"
  },
  {
    "id": "RF-085",
    "module": "Comunicação e relacionamento",
    "title": "Permitir segmentação por unidade, turma, aluno, responsável, perfil ou segmento.",
    "priority": "Must"
  },
  {
    "id": "RF-086",
    "module": "Comunicação e relacionamento",
    "title": "Permitir anexos em comunicados.",
    "priority": "Should"
  },
  {
    "id": "RF-087",
    "module": "Comunicação e relacionamento",
    "title": "Registrar confirmação de leitura.",
    "priority": "Should"
  },
  {
    "id": "RF-088",
    "module": "Comunicação e relacionamento",
    "title": "Permitir comunicados financeiros vinculados a cobranças.",
    "priority": "Should"
  },
  {
    "id": "RF-089",
    "module": "Comunicação e relacionamento",
    "title": "Permitir modelos de mensagem.",
    "priority": "Should"
  },
  {
    "id": "RF-090",
    "module": "Comunicação e relacionamento",
    "title": "Permitir canal de atendimento com solicitações e protocolos.",
    "priority": "Should"
  },
  {
    "id": "RF-091",
    "module": "Comunicação e relacionamento",
    "title": "Permitir categorização e status de solicitações.",
    "priority": "Should"
  },
  {
    "id": "RF-092",
    "module": "Comunicação e relacionamento",
    "title": "Permitir comunicados emergenciais.",
    "priority": "Could"
  },
  {
    "id": "RF-093",
    "module": "Portal do responsável e aluno",
    "title": "Permitir convite e ativação de acesso do responsável.",
    "priority": "Must"
  },
  {
    "id": "RF-094",
    "module": "Portal do responsável e aluno",
    "title": "Exibir alunos vinculados ao responsável.",
    "priority": "Must"
  },
  {
    "id": "RF-095",
    "module": "Portal do responsável e aluno",
    "title": "Exibir comunicados e calendário.",
    "priority": "Must"
  },
  {
    "id": "RF-096",
    "module": "Portal do responsável e aluno",
    "title": "Exibir mensalidades e pagamentos conforme papel financeiro.",
    "priority": "Must"
  },
  {
    "id": "RF-097",
    "module": "Portal do responsável e aluno",
    "title": "Exibir boletim e frequência quando liberados.",
    "priority": "Should"
  },
  {
    "id": "RF-098",
    "module": "Portal do responsável e aluno",
    "title": "Permitir atualização cadastral solicitada pelo responsável.",
    "priority": "Should"
  },
  {
    "id": "RF-099",
    "module": "Portal do responsável e aluno",
    "title": "Permitir abertura de solicitações para secretaria.",
    "priority": "Should"
  },
  {
    "id": "RF-100",
    "module": "Portal do responsável e aluno",
    "title": "Permitir acesso do aluno quando aplicável.",
    "priority": "Could"
  },
  {
    "id": "RF-101",
    "module": "Portal do professor",
    "title": "Exibir painel do professor com turmas vinculadas.",
    "priority": "Must"
  },
  {
    "id": "RF-102",
    "module": "Portal do professor",
    "title": "Permitir chamada rápida por turma.",
    "priority": "Must"
  },
  {
    "id": "RF-103",
    "module": "Portal do professor",
    "title": "Permitir lançamento de notas.",
    "priority": "Must"
  },
  {
    "id": "RF-104",
    "module": "Portal do professor",
    "title": "Permitir registrar conteúdo da aula.",
    "priority": "Should"
  },
  {
    "id": "RF-105",
    "module": "Portal do professor",
    "title": "Permitir registrar ocorrência de aluno.",
    "priority": "Should"
  },
  {
    "id": "RF-106",
    "module": "Portal do professor",
    "title": "Exibir pendências de lançamento.",
    "priority": "Must"
  },
  {
    "id": "RF-107",
    "module": "BI, dashboards e relatórios",
    "title": "Exibir dashboard executivo com alunos ativos, matrículas, inadimplência e receita.",
    "priority": "Must"
  },
  {
    "id": "RF-108",
    "module": "BI, dashboards e relatórios",
    "title": "Exibir dashboard operacional da secretaria.",
    "priority": "Should"
  },
  {
    "id": "RF-109",
    "module": "BI, dashboards e relatórios",
    "title": "Exibir dashboard financeiro.",
    "priority": "Must"
  },
  {
    "id": "RF-110",
    "module": "BI, dashboards e relatórios",
    "title": "Exibir dashboard pedagógico.",
    "priority": "Should"
  },
  {
    "id": "RF-111",
    "module": "BI, dashboards e relatórios",
    "title": "Permitir relatórios por unidade, turma, período e segmento.",
    "priority": "Must"
  },
  {
    "id": "RF-112",
    "module": "BI, dashboards e relatórios",
    "title": "Permitir exportação de relatórios.",
    "priority": "Must"
  },
  {
    "id": "RF-113",
    "module": "BI, dashboards e relatórios",
    "title": "Permitir alertas operacionais configuráveis.",
    "priority": "Should"
  },
  {
    "id": "RF-114",
    "module": "Multiunidade e redes",
    "title": "Permitir gestão de múltiplas unidades por mantenedora/rede.",
    "priority": "Should"
  },
  {
    "id": "RF-115",
    "module": "Multiunidade e redes",
    "title": "Permitir usuários com acesso consolidado ou restrito por unidade.",
    "priority": "Must"
  },
  {
    "id": "RF-116",
    "module": "Multiunidade e redes",
    "title": "Permitir relatórios consolidados entre unidades.",
    "priority": "Should"
  },
  {
    "id": "RF-117",
    "module": "Multiunidade e redes",
    "title": "Permitir padronização de configurações por rede.",
    "priority": "Could"
  },
  {
    "id": "RF-118",
    "module": "Compliance, privacidade e governança",
    "title": "Permitir registro de consentimentos quando necessário.",
    "priority": "Must"
  },
  {
    "id": "RF-119",
    "module": "Compliance, privacidade e governança",
    "title": "Permitir gestão de bases legais por finalidade de tratamento.",
    "priority": "Should"
  },
  {
    "id": "RF-120",
    "module": "Compliance, privacidade e governança",
    "title": "Permitir solicitação de acesso, correção ou exclusão/bloqueio quando aplicável.",
    "priority": "Should"
  },
  {
    "id": "RF-121",
    "module": "Compliance, privacidade e governança",
    "title": "Permitir mascaramento de dados sensíveis para perfis sem autorização.",
    "priority": "Must"
  },
  {
    "id": "RF-122",
    "module": "Compliance, privacidade e governança",
    "title": "Registrar auditoria de exportações, alterações financeiras e alterações cadastrais sensíveis.",
    "priority": "Must"
  },
  {
    "id": "RF-123",
    "module": "Compliance, privacidade e governança",
    "title": "Permitir configuração de retenção e inativação de dados conforme política.",
    "priority": "Should"
  },
  {
    "id": "RF-124",
    "module": "Integrações e automações",
    "title": "Permitir integração futura com gateways de pagamento.",
    "priority": "Should"
  },
  {
    "id": "RF-125",
    "module": "Integrações e automações",
    "title": "Permitir integração futura com WhatsApp Business Platform.",
    "priority": "Should"
  },
  {
    "id": "RF-126",
    "module": "Integrações e automações",
    "title": "Permitir integração com e-mail transacional.",
    "priority": "Must"
  },
  {
    "id": "RF-127",
    "module": "Integrações e automações",
    "title": "Permitir integração futura com Google Classroom/Microsoft.",
    "priority": "Could"
  },
  {
    "id": "RF-128",
    "module": "Integrações e automações",
    "title": "Disponibilizar API e webhooks em fase avançada.",
    "priority": "Could"
  },
  {
    "id": "RF-129",
    "module": "Integrações e automações",
    "title": "Permitir automações de cobrança e comunicação por regras.",
    "priority": "Should"
  },
  {
    "id": "RF-130",
    "module": "IA e automação inteligente",
    "title": "Sugerir textos de comunicados com revisão humana.",
    "priority": "Could"
  },
  {
    "id": "RF-131",
    "module": "IA e automação inteligente",
    "title": "Resumir histórico de atendimento.",
    "priority": "Could"
  },
  {
    "id": "RF-132",
    "module": "IA e automação inteligente",
    "title": "Sugerir ações para inadimplência.",
    "priority": "Could"
  },
  {
    "id": "RF-133",
    "module": "IA e automação inteligente",
    "title": "Detectar cadastros incompletos ou inconsistentes.",
    "priority": "Should"
  },
  {
    "id": "RF-134",
    "module": "IA e automação inteligente",
    "title": "Indicar risco de evasão como alerta assistivo.",
    "priority": "Could"
  }
];

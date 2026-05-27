# 🏥 Monitor de Licitações – GMSS

Painel web de monitoramento nacional de licitações públicas compatíveis com os serviços da GMSS (área de saúde).

## Acesso

| Campo   | Valor  |
|---------|--------|
| Usuário | `eder` |
| Senha   | `2026` |

## Funcionalidades

- 18 portais de licitação mapeados (federais, estaduais, plataformas, saúde)
- Palavras-chave configuráveis por serviço
- Links de busca direta em cada portal
- Monitoramento diário automático via Claude (08h00)

## Deploy no GitHub Pages

1. Faça push deste repositório para o GitHub
2. Vá em **Settings → Pages**
3. Em *Source*, selecione **Deploy from a branch**
4. Escolha a branch `main` e pasta `/ (root)`
5. Clique em **Save** — o site ficará disponível em `https://SEU-USUARIO.github.io/gmss-licitacoes/`

## Estrutura

```
gmss-licitacoes/
└── index.html    ← painel completo (HTML, CSS e JS em um só arquivo)
└── README.md
```

## Serviços monitorados

- Locação de equipamentos hospitalares
- Gestão de mão de obra médica
- Consultas ambulatoriais
- Pronto socorro / pronto atendimento
- Locação de veículos e ambulâncias

---
*Uso exclusivo GMSS e assistentes autorizados.*

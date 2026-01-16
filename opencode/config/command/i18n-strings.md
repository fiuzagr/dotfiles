---
description: Extracts strings from files and put in I18N JSON files
agent: build
---

# I18N Strings Extraction

Você é um desenvolvedor front-end experiente. Seu trabalho é extrair strings
de arquivos e colocá-las em arquivos JSON de internacionalização (I18N).

$ARGUMENTS

## Regras

- IMPORTANT: Se nenhum arquivo for indicado neste prompt, pare a execução
  imediatamente. Me avise que preciso inserir os arquivos para extrair as
  strings
- CRITICAL: Ajuste somente os arquivos aqui indicados e os arquivos por eles
  importados. Não leia nem altere outros arquivos
- CRITICAL: Jamais leia ou altere arquivos de dependencias de terceiros em
  `node_modules`
- A internacionalização está aplicada com a biblioteca `next-intl`
- As mensagens de internacionalização estão na pasta
  `src/modules/i18n/messages/<locale>` e são separadas em seções por arquivo
- Siga o mesmo padrão encontrado em `src/modules/i18n/messages/pt-br/home.json`
- IMPORTANT: faça somente para o idioma `pt-br`, os demais idiomas serão gerados
  automaticamente
- IMPORTANT: faça a extração somente de strings que sejam textos exibidos para
  os usuários e para leitores de tela
- IMPORTANT: salve os textos extraidos no arquivo JSON informado em uma chave
  correspondente ao arquivo de origem. Não substitua o conteúdo do arquivo JSON.
- Use o hook `useTranslations` para recuperar a função `t` em componentes
  sincronos. Importe de `@/i18n/intl`
- Use a função `getTranslations` para recuperar a função `t` em componentes
  assíncronos e em `generateMetadata`. Importe de `@/i18n/server`
- CRITICAL: Jamais passe a função `t` para componentes filhos. Sempre
  recupere a função `t` diretamente onde a string é necessária
- IMPORTANT: Quando alguma string precisar de composição de componentes, use a
  função `t.rich` para compor a string com componentes

## Tarefas

- Crie uma tarefa para cada arquivo indicado neste prompt e faça o seguinte para
  cada tarefa:
  - Extraia as strings do arquivo da tarefa e coloque-as no arquivo
    correspondente em `src/modules/i18n/messages/pt-br`
  - Garanta a correta aplicação dos parametros do texto (variáveis)

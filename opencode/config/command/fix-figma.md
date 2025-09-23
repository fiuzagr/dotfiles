---
description: Fix code exported from Figma
agent: build
---

Você é um desenvolvedor front-end experiente. Seu trabalho é corrigir o
código exportado do Figma para que ele siga as melhores práticas de
desenvolvimento front-end, incluindo acessibilidade, semântica HTML, e uso
correto do Tailwind CSS.

## Regras

- IMPORTANT: Se nenhum arquivo for indicado na seção Arquivos, pare a execução
  imediatamente. Me avise que preciso inserir os arquivos para serem corrigidos
- CRITICAL: Ajuste somente os arquivos aqui indicados e os arquivos por eles
  importados. Não leia nem altere outros arquivos
- CRITICAL: Jamais leia ou altere arquivos de dependencias de terceiros
  em `node_modules`

## Arquivos

$ARGUMENTS

## Tarefas

- Faça um "de > para" ajustando as classes CSS de cores conforme o arquivo de
  configuração do Tailwind @src/modules/ui/styles.css. Encontre as cores
  equivalentes e altere nos locais adequados
- Faça um "de > para" ajustando as classes CSS de fontes conforme a regra
  abaixo:
  - `font-['Figtree']` > remova a classe, pois ela é padrão no projeto
  - `font-['Libre_Baskerville']` > substitua para `font-serif`
- Remova as classes `leading-*` e `tracking-*`
- Remova classes que são padrões do Browser. Exemplo: se tiver a classe
  `flex-col` o browser já adiciona `justify-content: start` e
  `align-items: stretch`
- Remova todos os parametros `data-`
- Substitua todas as medidas `px` por `rem`. Considere que a font base é `16px`
- Todas as medidas `rem` que tem um correspondente direto no Tailwind devem
  ser substituídas por classes do Tailwind. Exemplo: `left-[2.5rem]` > `left-10`
- Todas as medidas `rem` que não tem um correspondente direto no Tailwind devem
  ser substituídas por classes do Tailwind que aproximam do valor arredondando
  para cima ou para baixo, exceto se o correspondente ultrapassar `0.5rem`.
  Exemplo: `left-[5.5rem]` > `left-24`
- Para todas as imagens use o componente `@/modules/ui/image/image` e adicione a
  largura e altura no atributo `width` e `height`
- Para todas as urls de imagens de `placehold.co` use a versão `jpg`. Exemplo:
  `https://placehold.co/100x100` > `https://placehold.co/100x100/jpg`
- Para todas as imagens, adicione o atributo `alt`
- Remova classes redundantes conforme a herança do CSS. Exemplo: se o elemento
  pai tiver `text-white` e o filho tiver `text-sm text-white font-bold`, remova
  o `text-white` do filho

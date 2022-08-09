# Introdução

Olá, estarei apresentando o trabalho "Parametrização e curadoria de pacote em R para geração
e manipulação de grafos".

Redes, estruturas compostas por nós interligados por arestas, estão presentes em vários fenômenos naturais e sociais, como cadeias alimentares, comunidades e interação de proteínas.

Embora a visualização dessas redes ser essencial para a análise desses fenômenos, o ecossistema computacional R possui soluções nativas insatisfatórias para a visualização e manipulação desses dados. Apresentamos, então, a construção de um pacote, easylayout, que permite a criação e a manipulação de visualizações e layouts de redes.

# Metodologia

O pacote em R foi construído utilizando as bibliotecas Igraph e Shiny. Com a computação do layout sendo feito pela biblioteca JavaScript VivaGraphJS, que interage com a sessão R através do Shiny.

# Resultados

A ferramenta interage com a sessão R através de forma interativa e altamente parametrizável, como podemos ver ao lado, e possibilita a geração de objetos em R que correspondam às manipulações gráficas realizadas.

Além disso, a nossa ferramenta possui alta performance ao computar o layout de redes, mesmo ao lidar com redes grande de mais de 5000 nós.

# Conclusões

Portanto, temos uma ferramenta eficiente em R que possibilita uma análise mais coerente, por ser interoperável com outros recursos da linguagem. 

No entanto, melhorias ainda são necessárias, sobretudo na própria interface e também quanto a permitir outras escolhas de bibliotecas para visualização.

# Agradecimentos

Com isso, agradeço a todos os co-autores do trabalho, à UFRN e ao CNPQ. Obrigado.
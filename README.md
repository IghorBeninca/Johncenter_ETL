# 🏭 Johncenter ETL

Projeto de Engenharia de Dados para a **Johncenter**, distribuidora oficial **Colgate** e **3M**.

## 🎯 Objetivo
Construir um Data Warehouse moderno e robusto para centralizar dados dispersos e gerar inteligência de negócio (BI) para as áreas:
*   **🚚 Logística:** Controle de estoque, ruptura e eficiência de entrega.
*   **💼 Comercial:** Análise de vendas por vendedor, região, mix de produtos e positivação.
*   **💰 Financeira:** Acompanhamento de margem, faturamento e custos.

## 🏗 Arquitetura de Dados (Medallion Architecture)
O projeto segue a arquitetura de camadas (Bronze, Silver, Gold) para garantir qualidade e governança:

### 1. 🥉 Bronze (Staging) - *Atual*
*   **O que é:** Cópia fiel (raw) dos dados de origem.
*   **Ferramenta:** Apache Hop.
*   **Estratégia:** Pipelines `.hpl` extraem dados do ERP/Sistemas e carregam tabelas `stg_` no Postgres.
*   **Status:** ✅ Concluído (~30 tabelas mapeadas).

### 2. 🥈 Silver (Trusted) - *Próximo Passo*
*   **O que é:** Dados limpos, padronizados e integrados.
*   **Transformações:**
    *   Tratamento de nulos e tipagem de dados (texto para data, string para decimal).
    *   Regras de negócio (ex: cálculo de valor líquido).
    *   Deduplicação.
*   **Estratégia Técnica:** **ELT (Extract, Load, Transform)**.
    *   Utilizaremos **SQL** dentro do Postgres para processar esses dados, pois é mais performático para grandes volumes que o processamento em memória do ETL tradicional.
    *   O Apache Hop será o **orquestrador**, disparando os scripts SQL na ordem correta.

### 3. 🥇 Gold (Analytics)
*   **O que é:** Dados modelados para BI (Star Schema).
*   **Modelagem:** Fatos (Vendas, Estoque) e Dimensões (Cliente, Produto, Tempo).
*   **Consumo:** Power BI / Metabase.

## 🛠 Tech Stack & Decisões Técnicas

*   **Orquestração & Ingestão:** [Apache Hop](https://hop.apache.org/)
    *   *Por que?* Visual, fácil manutenção e ótimo para conectar em diversas fontes.
*   **Data Warehouse:** [PostgreSQL](https://www.postgresql.org/)
    *   *Por que?* Robusto, gratuito e suporta cargas pesadas de SQL para as transformações.
*   **Infraestrutura:** Docker & Docker Compose
    *   *Por que?* Garante que o ambiente rode igual em qualquer máquina.
*   **Linguagens:**
    *   **SQL:** Será a linguagem principal para transformação (Silver/Gold). É universal, performático e fácil de auditar.
    *   **Python:** Será utilizado **apenas se necessário** para casos específicos (ex: conectar em uma API complexa que o Hop não suporte nativamente ou scripts de automação externa). Para o "grosso" do ETL, manteremos no SQL/Hop para reduzir complexidade.

## 🚀 Como Rodar

1.  **Pré-requisitos:** Docker e Git instalados.
2.  **Clone o repositório:**
    ```bash
    git clone https://github.com/IghorBeninca/Johncenter_ETL.git
    cd Johncenter_ETL
    ```
3.  **Suba o ambiente:**
    ```bash
    docker-compose up -d
    ```
4.  **Acesse:**
    *   Apache Hop: `http://localhost:8080`
    *   Postgres: `localhost:5432` (User: `hopuser`, Pass: `hoppass`)

## 📅 Roadmap

- [x] Configuração do Ambiente (Docker)
- [x] Ingestão da Camada Bronze (Staging)
- [ ] **Criação da Camada Silver (Limpeza e Padronização)**
- [ ] **Modelagem da Camada Gold (Fatos e Dimensões)**
- [ ] **Criação de Dashboards (Power BI)**

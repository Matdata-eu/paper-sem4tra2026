# Connected Data London 2026 — Submission Outline

## Title

**Building the Norwegian Railway Knowledge Graph, where the Semantic Web Stack Runs Off the Track**

> Note on the "new spin": the academic paper is a tooling-centric lessons-learned report.
> For CDL this is reframed as a *story of production impact* — a national infrastructure
> manager collapsing dozens of conflicting copies of "the same railway" into one
> authoritative knowledge graph — plus an *honest, opinionated* verdict on where today's
> graph stack delivers and where it still falls short. "Mind the Gap" is deliberately
> London/railway-flavoured and doubles as the technical thesis (the *gap* between a
> geometry-centric stack and a topology-centric domain).

---

## Outline — 500-word version (paste this into the form)

> **The problem.** A national railway exists simultaneously in a dozen systems —
> maintenance, projects, operations, GIS, regulatory reporting — and they all disagree
> about the same track. Every use case grew its own application, its own data model and
> its own copy of the network, so the "same" railway looks different everywhere. Changes in
> one system never reach the others, and reconciliation is manual and error-prone.
>
> **The opportunity.** A knowledge graph as a semantic integration layer: one authoritative
> model that serves reference data to every use case from a single source of truth. We
> built exactly that, in production, for the Norwegian infrastructure manager Bane NOR —
> today roughly 13 million triples across 17 ontologies, covering more than 5,000 km of
> track, running on Kubernetes.
>
> **Why this matters.** This is a real, at-scale deployment, not a proof of concept — and
> it breaks the usual geospatial assumptions. Most graph and GIS work is geometry-first:
> points, lines, polygons. Railways are topology-first: an asset's meaning comes from where
> it sits in the network graph and how it affects routing, not from its coordinates. A
> signal can physically stand closer to the wrong track, so geometry lies. That distinction
> exposes a real, generalisable gap in mainstream Semantic Web tooling that affects anyone
> building network-shaped graphs — utilities, telecoms, logistics, road and pipeline
> networks.
>
> **How we addressed it.** We treat topology as the foundation — nodes, edges and explicit
> navigability — and map every source system onto one shared model ("things, not strings").
> We ingest heterogeneous formats with SPARQL Anything, using one language for both mapping
> and querying. We show the honest evolution of where transformation should live: from
> ad-hoc SPARQL, through ~50 ordered post-processing queries (an imperative program in
> disguise), toward declarative SHACL rules with validation and lineage. And we generate
> the EU Register of Infrastructure (RINF) export directly from the graph, so compliance
> becomes a view of the model rather than a parallel dataset that drifts.
>
> **The impact.** One authoritative model replacing dozens of drifting copies; the first
> ever submission of European railway data at the micro (topology) level of detail, made
> possible precisely because the graph is topology-based. We also share hard numbers — for
> example, that the choice of SHACL engine changed our runtime by an order of magnitude —
> and an evidence-backed wish list for the community: native linear referencing and
> topology-aware functions in GeoSPARQL and triple stores.
>
> **Audience and takeaways.** For a business-and-technical audience at intermediate level;
> no railway knowledge assumed. Attendees leave with a mental model of topology-first vs
> geometry-first data, a battle-tested pipeline pattern for building a production graph from
> messy sources, and a frank map of where the Semantic Web stack shines and where it still
> runs off the track.

*(~495 words.)*

---

## Suggested track

**Edges track** (innovation, some technical detail, aimed at both business and technical
audiences). The talk pairs a business narrative (single source of truth, regulatory
reporting, avoiding drift) with concrete technical findings (SPARQL Anything, SHACL,
GeoSPARQL limits) — a natural fit for Edges. It can be dialled toward **Nodes** (drop
the code, keep the story) or **Educational** (add live SHACL/GeoSPARQL detail) if the
Programme Committee prefers.

---

## Concise description

### The problem / the opportunity

A railway infrastructure manager doesn't just run trains — it builds, maintains, renews
and plans thousands of kilometres of track, signals, switches, bridges and overhead lines
decades ahead. Historically every use case (asset maintenance, ERTMS rollout, capacity
planning, timetabling, regulatory reporting) grew its own application, its own data model
and its own copy of the railway. The result: dozens of overlapping, contradictory
representations of the *same* network — sometimes so divergent they look like different
railways. Changes in one system never reach the others; reconciliation is manual and
error-prone.

The opportunity is a **knowledge graph as a semantic integration layer**: one
authoritative model that serves reference data to every use case from a single source of
truth. We built exactly that, in production, for a national infrastructure manager.

### Why this matters to CDL attendees and the world

- **A real, at-scale production graph**, not a proof of concept: ~13 million triples,
  17 ontologies, 5,000+ km of track, running on Kubernetes with Airflow orchestration.
- **A domain that breaks the usual geospatial assumptions.** Most graph/GIS work is
  geometry-first (points, lines, polygons). Railways are **topology-first**: an asset's
  meaning comes from *where it sits in the network graph and how it affects routing*, not
  its absolute coordinates. This exposes a real, generalisable **gap** in mainstream
  Semantic Web tooling (GeoSPARQL, SHACL engines) that matters to anyone doing temporal,
  geospatial, or network-shaped knowledge graphs — utilities, telecoms, logistics, supply
  chains, road networks.
- **Regulatory impact:** the graph produces the EU Register of Infrastructure (RINF)
  export directly, enabling the **first-ever micro (topology) level RINF submission** —
  reporting becomes a *view* of the model, not a parallel dataset that drifts.

### How we addressed it

- **Topology as the foundation.** We treat the railway as a graph of nodes and edges with
  explicit *navigability*, and map every source system's own topology onto one shared
  model. "Things, not strings": assets are positioned by intrinsic coordinates on the
  network, not by ambiguous names or kilometre posts.
- **Pragmatic ingestion with SPARQL Anything + Facade-X:** one language (SPARQL) for both
  mapping and querying ~40 asset types, avoiding a second mapping language.
- **Evolving *where* transformation lives:** from ad-hoc SPARQL `CONSTRUCT`, through ~50
  ordered post-processing queries (an imperative program in disguise), toward **declarative
  SHACL rules** — with validation, lineage and dependency-ordered execution.
- **RINF publication directly from the graph** via SHACL-AF rules validated against ERA's
  official shapes.
- **An honest verdict on GeoSPARQL:** it's excellent for geometry, but has no native
  linear referencing, kilometrage, routing or topology traversal — so a large share of
  spatial logic had to stay in SpatiaLite SQL *outside* the graph. We name exactly what's
  missing.

### The impact of the work

- One authoritative model replacing dozens of drifting copies — a genuine single source
  of truth feeding maintenance, projects, operations and reporting.
- First micro-level RINF submission to the EU Agency for Railways, made possible *because*
  the graph is topology-based — regulatory compliance as a by-product of good modelling.
- A concrete, evidence-backed **wish list for the community**: native linear referencing
  and topology-aware functions in GeoSPARQL / triple stores, and mature SHACL rule tooling
  with lineage. Also a measured finding that SHACL engine choice changes runtime by an
  order of magnitude (~10 min vs ~2 h on the same rules).

---

## Target audience

- **Business / technical:** **both.** A business narrative (integration, single source of
  truth, compliance, avoiding drift) wrapped around concrete technical lessons.
- **Level:** **Intermediate.** Accessible to anyone who has seen a knowledge graph;
  rewarding for practitioners who have wrestled with real ingestion and geospatial data.
- **Required background:** a working idea of what a knowledge graph / RDF is helps but is
  not essential. No railway knowledge assumed — the domain is introduced from first
  principles. Familiarity with SPARQL, SHACL or GIS is a bonus, not a prerequisite.

### What attendees will get

- A clear mental model of **topology-first vs geometry-first** data — and how to tell
  which one your domain actually is.
- A **battle-tested pipeline pattern** for building a production KG from messy, conflicting
  sources (SPARQL Anything → graph → SHACL → regulated exports), including the mistakes we
  made and would avoid next time.
- A frank map of **where the Semantic Web stack shines and where it breaks** for network /
  geospatial data, so they can plan around the gaps instead of discovering them the hard
  way.
- Reusable takeaways for **any network-shaped domain**: utilities, telecoms, logistics,
  road and pipeline networks, supply chains.

---

## Speaker profile (draft — please edit)

- **Background and experience:** Semantic-mapping and knowledge-graph practitioner
  (Matdata), working with the Norwegian infrastructure manager Bane NOR on its Digital
  Infrastructure Model (DIM). Hands-on experience mapping multiple proprietary and standard
  railway topology/positioning models (railML, RTM/RSM, OpenTNF, and vendor systems).
- **Motivation for speaking at CDL:** to share an honest, production-grade experience
  report with a practitioner community, and to rally support for closing concrete gaps in
  geospatial/topology tooling that hold back an entire class of network knowledge graphs.
- **References to previous talks:** _(add links to prior talks / the Sem4Tra 2026 paper
  once available)_.

---

## Logistics checklist

- **Format:** 25-min presentation + 10-min moderated Q&A.
- **Video:** ≤3 min, **9:16 vertical**, story format, publicly accessible link
  (see `script.md`). Counts for 25% of the score — mandatory.
- **Deadline:** 31 August 2026. **Notification:** 14 September 2026. **Event:** 12 November
  2026 (London).
- **Vendor policy:** presentation submissions by vendor staff are not evaluated — submit
  as a Bane NOR / infrastructure-manager use case, with Matdata credited as collaborator,
  and keep the talk skills- and use-case-centric rather than product-centric.

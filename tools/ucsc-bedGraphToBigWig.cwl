#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: |
  ucsc-bedGraphToBigWig.cwl is developed for CWL consortium

  Original tool usage:
         bedGraphToBigWig in.bedGraph chrom.sizes out.bw

      where in.bedGraph is a four column file in the format:
            <chrom> <start> <end> <value>
      and chrom.sizes is a two-column file/URL: <chromosome name> <size in bases>
      and out.bw is the output indexed big wig file.
      If the assembly <db> is hosted by UCSC, chrom.sizes can be a URL like
        http://hgdownload.cse.ucsc.edu/goldenPath/<db>/bigZips/<db>.chrom.sizes
      or you may use the script fetchChromSizes to download the chrom.sizes file.
      If not hosted by UCSC, a chrom.sizes file can be generated by running
      twoBitInfo on the assembly .2bit file.
      The input bedGraph file must be sorted, use the unix sort command:
        sort -k1,1 -k2,2n unsorted.bedGraph > sorted.bedGraph

requirements:
- class: InlineJavascriptRequirement
- $import: envvar-global.yml
- $import: ucsc-userapps-docker.yml

inputs:
- id: "#input"
  type: File
  inputBinding:
    position: 2

- id: "#genomeFile"
  type: File
  inputBinding:
    position: 3

- id: "#bigWig"
  type: string
  inputBinding:
    position: 4

- id: "#unc"
  type: ["null",boolean]
  description: "If set, do not use compression."
  inputBinding:
    position: 1
    prefix: "-unc"

- id: "#itemsPerSlot"
  type: ["null",int]
  description: |
    -itemsPerSlot=N - Number of data points bundled at lowest level. Default 1024
  inputBinding:
    separate: false
    position: 1
    prefix: "-itemsPerSlot="

- id: "#blockSize"
  type: ["null",int]
  description: |
    -blockSize=N - Number of items to bundle in r-tree.  Default 256
  inputBinding:
    separate: false
    position: 1
    prefix: "-blockSize="

outputs:
  - id: "#bigWigOut"
    type: File
    outputBinding:
      glob: $(inputs.bigWig)

baseCommand: ["bedGraphToBigWig"]

$namespaces:
  s: http://schema.org/

$schemas:
- https://sparql-test.commonwl.org/schema.rdf

s:mainEntity:
  $import: ucsc-metadata.yaml

s:downloadUrl: https://github.com/common-workflow-language/workflows/blob/master/tools/ucsc-bedGraphToBigWig.cwl
s:codeRepository: https://github.com/common-workflow-language/workflows
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: "Common Workflow Language"
  s:url: http://commonwl.org/

s:author:
  class: s:Person
  s:name: "Andrey Kartashov"
  s:email: mailto:Andrey.Kartashov@cchmc.org
  s:sameAs:
  - id: http://orcid.org/0000-0001-9102-5681
  s:worksFor:
  - class: s:Organization
    s:name: "Cincinnati Children's Hospital Medical Center"
    s:location: "3333 Burnet Ave, Cincinnati, OH 45229-3026"
    s:department:
    - class: s:Organization
      s:name: "Barski Lab"

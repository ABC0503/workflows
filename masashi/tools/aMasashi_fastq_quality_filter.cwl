cwlVersion: v1.0
class: CommandLineTool
doc: read quality filtering

baseCommand: fastq_quality_filter

hints:
- class: DockerRequirement
  dockerPull: biowardrobe2/fastx_toolkit:v0.0.14

inputs:

  q:
    type:
    - "null"
    - int
    doc: |
      Minimum quality score to keep
    inputBinding:
      position: 0
      prefix: '-q'

  p:
    type:
    - "null"
    - int
    doc: |
     Minimum percent of bases that must have [-q] quality
    inputBinding:
      position: 1
      prefix: '-p'

  Q33:
    type:
    - "null"
    - boolean
    doc: |
    inputBinding:
      position: 2
      prefix: '-Q33'

  fastq:
    type: File
    inputBinding:
      position: 3
      prefix: '-i'
    doc: "Input only fastq"

  # output_filename:
  #   type: string
  #   inputBinding:
  #     position: 9
  #     prefix: "-o"
  #     # valueFrom: $(get_output_prefix("_default_"))
  #   doc: "Output file prefix"




outputs:
  filterred_file:
    type: stdout

stdout: filterred.fastq

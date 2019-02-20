cwlVersion: v1.0
class: CommandLineTool
doc: read count against reference by samtools

requirements:
- class: InlineJavascriptRequirement
- class: ShellCommandRequirement

baseCommand:
  - samtools
  - idxstats

inputs:

  mapped_bam:
    type: File
    inputBinding:
      position: 0
    secondaryFiles:
      - .bai
    doc: |
      Input only bam

  b:
    type: string[]
    inputBinding:
      position: 2
      prefix: "-b"
      itemSeparator: " -b "
      shellQuote: False



  output_filename:
    type: string


outputs:
  # readcount:
  #   type: stdout

  readcount:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)


stdout: $(inputs.output_filename)

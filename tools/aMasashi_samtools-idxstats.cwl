cwlVersion: v1.0
class: CommandLineTool
doc: read count against reference by samtools

baseCommand: [samtools, idxstats]

inputs:

  mapped_bam:
    type: File
    inputBinding:
      position: 0
    secondaryFiles:
      - .bai
    doc: |
      Input only bam

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

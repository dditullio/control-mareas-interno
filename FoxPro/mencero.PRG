USE mcong
INDEX on especie TO tt
GO top
DO WHILE .not. EOF()
  IF (especie="Macruronus magellanicus" .or. especie="Salilota australis" .or. especie="Micromesistius australis" .or. especie="Merluccius australis") .and. peso_mues=0
    ? especie,";",marea,";",lance
  ENDIF
  SKIP
ENDDO

#!/bin/bash
# 
# script de empaquetamiento y desempaquetamiento del dev_flash MODIFICADO
# Modificado por Matercrack
# Autor Original: Copyright(C) Youness Alaoui (KaKaRoTo)
# 
# This software is distributed under the terms of the GNU General Public
# License ("GPL") version 3, as published by the Free Software Foundation.
# Este script puede ser modificado pero respentando los terminos del GNU
# No adueñarse del trabajo de los demas
# Saludos desde Mexico

BUILDDIR=`pwd`
export PATH=$PATH:$BUILDDIR:$BUILDDIR/../Des-Emp_dev-flash/

AWK="awk"
PUP="pup"
PKG="pkg"
UNPKG="unpkg"
LOGFILE="$BUILDDIR/Des-Emp_dev-flash.log"
die()
{
    log "$@"
    exit 1
}

log ()
{
    echo "$@"
    echo "$@" >> $LOGFILE
}
echo > $LOGFILE
for i in `ls dev_flash*`; do ./devflash $i $i.tar ; tar -xvf ./$i.tar >>$LOGFILE ;rm $i.tar ; done
log "Se construyo el dev_flash primario"
log "####Desempaquetamiento y empaquetamiento del dev_flash####"
log "por Matercrack"
log "creditos a Kakaroto por la creacion del CFW y del script primario"
log "Iniciando..."
mkdir dev_flash_temp
cd dev_flash_temp
log "Desempaquetando archivos del dev_flash en dev_flash_temp"
for f in ../dev_flash*tar*; do
    $UNPKG $f "$(basename $f).tar" >> $LOGFILE 2>&1 || die "No se puede desempaquetar $f"
done
log "Recreando los pkg's"
for f in ../dev_flash*tar*; do
    $PKG retail $(basename $f).tar $(basename $f) >> $LOGFILE 2>&1 || die "No se puede recrear $f"
    log "Creando"
done
log "Terminado..."

FROM ckan/ckan-base:2.10.3

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

### Harvester ###
RUN pip3 install -e 'git+https://github.com/ckan/ckanext-harvest.git@v1.5.6#egg=ckanext-harvest' && \
    pip3 install -r https://raw.githubusercontent.com/ckan/ckanext-harvest/v1.5.6/requirements.txt

### DCAT ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-dcat.git@v1.5.1#egg=ckanext-dcat && \
     pip3 install -r https://raw.githubusercontent.com/ckan/ckanext-dcat/v1.5.1/requirements.txt

### Nadit ###
RUN  pip3 install -e git+https://git.fhgr.ch/resto/ckanext-nadit.git@main#egg=ckanext-nadit && \
     pip3 install -r https://git.fhgr.ch/resto/ckanext-nadit/-/raw/main/requirements.txt?ref_type=heads

## Make sure extra libraries needed for harvesting are available
RUN pip3 install -U rdflib-jsonld iribaker

# Copy custom initialization scripts
COPY docker-entrypoint.d/* /docker-entrypoint.d/
COPY supervisord.d/* /etc/supervisord.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY patches ${APP_DIR}/patches

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done

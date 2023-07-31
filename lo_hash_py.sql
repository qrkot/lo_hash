BEGIN;

  CREATE EXTENSION plpython3u;

	CREATE OR REPLACE FUNCTION lo_hash(loid oid, name text)
	    RETURNS bytea
	    LANGUAGE plpython3u
	AS $$
	    import hashlib
	
	    hash = hashlib.new(name)
	
	    # Check if large object exists.
	    plan = plpy.prepare("""
	        SELECT
	        FROM pg_largeobject_metadata
	        WHERE oid = $1
	    """, ['oid'])
	    rv = plpy.execute(plan, [loid])
	
	    if rv.nrows() == 0:
	        raise ValueError(f"large object {loid} does not exist")
	
	    # Get all pages (possibly zero).
	    plan = plpy.prepare("""
	        SELECT data
	        FROM pg_largeobject
	        WHERE loid = $1
	        ORDER BY pageno
	    """, ['oid'])
	    pages = plpy.cursor(plan, [loid])
	
	    for page in pages:
	        hash.update(page['data'])
	
	    return hash.digest()
	$$;

COMMIT;

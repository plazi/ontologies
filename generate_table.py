import csv
from rdflib import Graph, Namespace

def extract_term_definitions(ontology_file):
    """
    Extracts term definitions from the ontology file.

    Args:
        ontology_file (str): Path to the OWL ontology file.

    Returns:
        list: List of tuples containing term and definition pairs.
    """

    # Load the ontology file
    graph = Graph()
    graph.parse(ontology_file, format="n3")

    term_definitions = []

    # Set up the custom namespaces
    skos = Namespace("http://www.w3.org/2004/02/skos/core#")
    rdfs = Namespace("http://www.w3.org/2000/01/rdf-schema#")

    # Query for terms and their definitions using both properties
    query = """
    SELECT DISTINCT ?term ?definition
    WHERE {
        {
            ?term skos:definition ?definition .
        }
        UNION
        {
            ?term rdfs:comment ?definition .
        }
    }
    """
    results = graph.query(query, initNs={'skos': skos, 'rdfs': rdfs})

    # Extract term and definition pairs
    for row in results:
        term = str(row['term'])
        definition = str(row['definition'])
        term_definitions.append((term, definition))

    return term_definitions

def generate_csv(term_definitions, output_file):
    """
    Generates a CSV file with the given term definitions.

    Args:
        term_definitions (list): List of tuples containing term and definition pairs.
        output_file (str): Path to the output CSV file.
    """

    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Term', 'Definition'])
        writer.writerows(term_definitions)

# Example usage
ontology_file = "ontologies/taxonomic_nomenclatural_status_terms.owl"
output_file = "taxonomic_nomenclatural_status_terms.csv"
term_definitions = extract_term_definitions(ontology_file)
generate_csv(term_definitions, output_file)
print(f"CSV file '{output_file}' generated successfully.")

# The script performs the following steps:
#
#    It imports the necessary modules, including csv for working with CSV files and rdflib for parsing the ontology.
#    The extract_term_definitions function loads the ontology file using rdflib.Graph, parses it in N3 format, and sets up the required namespaces.
#    It defines a SPARQL query to retrieve terms and their definitions using the skos:definition and rdfs:comment properties.
#    The query is executed using graph.query, and the resulting term and definition pairs are stored in a list.
#    The function returns the list of term definitions.
#    The generate_csv function takes the term definitions and the desired output file path as input.
#    It creates a CSV file, writes the column headers, and writes the term definitions as rows in the CSV file using csv.writer.
#    The ontology_file and output_file variables in the example usage section are set to the respective file paths.
#    The extract_term_definitions function is called to extract the term definitions from the ontology.
#    The generate_csv function is called to generate the CSV file with the term definitions.
#    A success message is printed to indicate that the CSV file has been generated.

# Make sure to replace "ontologies/taxonomic_nomenclatural_status_terms.owl" with the actual path to your OWL ontology file, and "taxonomic_nomenclatural_status_terms.csv" with the desired name and path for the
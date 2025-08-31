#!/usr/bin/env python3
"""
Dramatic Hello World CLI Application

A theatrical presentation of repository information, channeling the spirit
of the repository to dramatically announce its purpose and contents.

This script presents itself as "the spirit of the repository, awakened to serve
its creative purpose" and announces project info with great fanfare, describing
the repo as "a vessel for AI-assisted creation" and technologies as "incantations"
or "runes".
"""

import sys
import traceback
import logging
from pathlib import Path
from typing import Optional, NoReturn

from rich.console import Console
from rich.panel import Panel
from rich.text import Text
from rich.align import Align
from rich.rule import Rule
from rich.padding import Padding


def read_file_dramatically(file_path: Path, file_description: str, console: Console) -> str:
    """
    Read a file with dramatic flair and error handling.
    
    Args:
        file_path: Path to the file to read
        file_description: Description of what the file contains for error messages
        console: Rich Console instance for output
    
    Returns:
        File contents as string
        
    Raises:
        FileNotFoundError: When the file cannot be found (handled with drama)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            return file.read().strip()
    except FileNotFoundError as e:
        # Create dramatic error message
        error_text = Text()
        error_text.append("💀 ALAS! The sacred ", style="bold red")
        error_text.append(f"{file_description}", style="bold yellow")
        error_text.append(" remains unwritten!\n\n", style="bold red")
        error_text.append(f"The scrolls of '{file_path}' have yet to be inscribed by mortal hands...\n", style="dim italic")
        error_text.append("The knowledge it should contain is lost to the void...", style="dim red")
        
        error_panel = Panel(
            error_text,
            title="[bold red on white]🔥 MISSING KNOWLEDGE 🔥[/bold red on white]",
            border_style="red",
            padding=(1, 2)
        )
        console.print(error_panel)
        raise e


def create_dramatic_header(console: Console) -> None:
    """Create an overly dramatic header introduction."""
    # Create dramatic title
    title_text = Text("🌟 THE REPOSITORY SPIRIT AWAKENS 🌟", style="bold magenta")
    title_panel = Panel(
        Align.center(title_text),
        border_style="bright_magenta",
        padding=(1, 2)
    )
    console.print("\n")
    console.print(title_panel)
    
    # Dramatic awakening message
    awakening_message = Text()
    awakening_message.append("Behold! ", style="bold cyan")
    awakening_message.append("I am the ", style="white")
    awakening_message.append("SPIRIT OF THIS REPOSITORY", style="bold yellow")
    awakening_message.append(",\n", style="white")
    awakening_message.append("awakened from digital slumber to serve its ", style="white")
    awakening_message.append("CREATIVE PURPOSE!", style="bold green")
    
    spirit_panel = Panel(
        Align.center(awakening_message),
        title="[bold blue]The Awakening[/bold blue]",
        border_style="blue",
        padding=(1, 2)
    )
    console.print(spirit_panel)


def announce_project_purpose(console: Console) -> None:
    """Announce the repository's purpose with great fanfare."""
    purpose_text = Text()
    purpose_text.append("This realm serves as a ", style="white")
    purpose_text.append("VESSEL FOR AI-ASSISTED CREATION", style="bold cyan")
    purpose_text.append(",\n", style="white")
    purpose_text.append("where ", style="white")
    purpose_text.append("human ideas", style="bold green")
    purpose_text.append(" and ", style="white")
    purpose_text.append("machine execution", style="bold blue")
    purpose_text.append("\n", style="white")
    purpose_text.append("converge in ", style="white")
    purpose_text.append("GLORIOUS HARMONY!", style="bold magenta")
    
    purpose_panel = Panel(
        Align.center(purpose_text),
        title="[bold yellow]The Sacred Purpose[/bold yellow]",
        border_style="yellow",
        padding=(1, 2)
    )
    console.print(purpose_panel)


def display_project_info(project_content: str, console: Console) -> None:
    """Display project information dramatically."""
    # Parse the project content
    lines = project_content.split('\n')
    project_name = "UNKNOWN PROJECT"
    project_desc = "A mysterious endeavor awaits definition..."
    
    for line in lines:
        if line.startswith("PROJECT NAME:"):
            project_name = line.split(":", 1)[1].strip().strip('"')
        elif line.startswith("TODO:") and "DESCRIPTION" in line:
            if len(lines) > lines.index(line) + 1:
                next_line = lines[lines.index(line) + 1]
                if next_line.strip():
                    project_desc = next_line.strip()
    
    # Create dramatic presentation of project info
    info_text = Text()
    info_text.append("The sacred essence whispers...\n\n", style="italic dim")
    info_text.append("Project Name: ", style="bold white")
    info_text.append(f"{project_name}", style="bold cyan")
    info_text.append("\n\nDescription: ", style="bold white")
    info_text.append(f"{project_desc}", style="italic green")
    
    if project_name == "UNKNOWN PROJECT" or "TODO" in project_desc:
        info_text.append("\n\n[dim italic]The project's identity awaits fuller revelation...[/dim italic]", style="dim yellow")
    
    info_panel = Panel(
        info_text,
        title="[bold cyan]🎯 Project Manifest 🎯[/bold cyan]",
        border_style="cyan",
        padding=(1, 2)
    )
    console.print(info_panel)


def display_tech_stack(tech_content: str, console: Console) -> None:
    """Display technology stack as magical incantations."""
    tech_text = Text()
    tech_text.append("The arcane knowledge of power speaks...\n\n", style="italic dim")
    
    if tech_content and tech_content.strip() != "TODO: Tech Stack Goes Here":
        tech_text.append("The sacred ", style="white")
        tech_text.append("TECHNOLOGICAL RUNES", style="bold magenta")
        tech_text.append(" that power this realm:\n\n", style="white")
        tech_text.append(f"{tech_content}", style="bold green")
        tech_text.append("\n\n[dim]These are the elemental forces harnessed to breathe life into digital dreams![/dim]", style="dim")
        
        tech_panel = Panel(
            tech_text,
            title="[bold magenta]⚡ Arcane Incantations ⚡[/bold magenta]",
            border_style="magenta",
            padding=(1, 2)
        )
    else:
        tech_text.append("The ", style="white")
        tech_text.append("TECHNOLOGICAL ARSENAL", style="bold yellow")
        tech_text.append(" remains ", style="white")
        tech_text.append("UNFORGED", style="bold red")
        tech_text.append("!\n\n", style="white")
        tech_text.append("The runes of power await inscription by skilled hands...", style="italic dim")
        
        tech_panel = Panel(
            Align.center(tech_text),
            title="[bold yellow]⚡ Awaiting Power ⚡[/bold yellow]",
            border_style="yellow",
            padding=(1, 2)
        )
    
    console.print(tech_panel)


def display_repo_structure(repo_content: str, console: Console) -> None:
    """Display repository structure information dramatically."""
    structure_text = Text()
    structure_text.append("The architectural wisdom reveals itself...\n\n", style="italic dim")
    
    if repo_content and repo_content.strip():
        structure_text.append("The ", style="white")
        structure_text.append("ARCHITECTURAL BLUEPRINT", style="bold blue")
        structure_text.append(" of this digital realm:\n\n", style="white")
        
        # Show first few lines of repo.md as a preview
        lines = repo_content.split('\n')[:8]
        preview = '\n'.join(lines)
        if len(repo_content.split('\n')) > 8:
            preview += "\n\n[dim italic]...and much more architectural wisdom awaits within the sacred scrolls...[/dim italic]"
            
        structure_text.append(preview, style="green")
        
        structure_panel = Panel(
            structure_text,
            title="[bold blue]📚 The Grand Design 📚[/bold blue]",
            border_style="blue",
            padding=(1, 2)
        )
    else:
        structure_text.append("The ", style="white")
        structure_text.append("GRAND ARCHITECTURAL SCROLLS", style="bold cyan")
        structure_text.append(" contain mysteries ", style="white")
        structure_text.append("YET UNKNOWN", style="bold red")
        structure_text.append("!\n\n", style="white")
        structure_text.append("The blueprint of this realm's structure awaits discovery...", style="italic dim")
        
        structure_panel = Panel(
            Align.center(structure_text),
            title="[bold red]📚 Lost Knowledge 📚[/bold red]",
            border_style="red",
            padding=(1, 2)
        )
    
    console.print(structure_panel)


def create_dramatic_footer(console: Console) -> None:
    """Create a dramatic closing message."""
    footer_text = Text()
    footer_text.append("The spirit has spoken! ", style="bold white")
    footer_text.append("✨", style="yellow")
    footer_text.append("\n", style="white")
    footer_text.append("May your code be ", style="white")
    footer_text.append("ELEGANT", style="bold green")
    footer_text.append(", your bugs be ", style="white")
    footer_text.append("MINIMAL", style="bold blue")
    footer_text.append(",\n", style="white")
    footer_text.append("and your deployments be ", style="white")
    footer_text.append("GLORIOUS!", style="bold magenta")
    
    footer_panel = Panel(
        Align.center(footer_text),
        title="[bold green]Final Blessing[/bold green]",
        border_style="green",
        padding=(1, 2)
    )
    console.print(footer_panel)
    console.print("\n")


def setup_logging(debug_mode: bool = False) -> None:
    """Configure logging based on debug mode."""
    level = logging.DEBUG if debug_mode else logging.INFO
    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.StreamHandler(sys.stderr)
        ]
    )


def main() -> int:
    """
    Main entry point for the dramatic hello world application.
    
    Returns:
        Exit code: 0 for success, various exit codes for different error types
    """
    # Check for debug flag
    debug_mode = '--debug' in sys.argv
    setup_logging(debug_mode)
    
    console = Console()
    
    try:
        # Clear the screen and create dramatic entrance
        console.clear()
        console.print()
        
        # Create dramatic header
        create_dramatic_header(console)
        
        # Announce the repository's purpose
        announce_project_purpose(console)
        
        # Define the sacred scrolls to read with dramatic separators
        files_to_read = [
            ("dev-journal/PROJECT-DESCRIPTION.md", "Project Description Tome", "🎯"),
            ("dev-journal/TECH-STACK.md", "Technology Grimoire", "⚡"),
            ("repo.md", "Architectural Codex", "📚")
        ]
        
        # Read and display each file dramatically
        for file_path, file_description, icon in files_to_read:
            console.rule(f"[bold cyan]{icon} REVEALING {file_description.upper()} {icon}[/bold cyan]")
            console.print()
            
            try:
                content = read_file_dramatically(Path(file_path), file_description, console)
                if file_path == "dev-journal/PROJECT-DESCRIPTION.md":
                    display_project_info(content, console)
                elif file_path == "dev-journal/TECH-STACK.md":
                    display_tech_stack(content, console)
                elif file_path == "repo.md":
                    display_repo_structure(content, console)
            except FileNotFoundError:
                # Error already handled dramatically in read_file_dramatically
                pass
            
            console.print()
        
        # Create dramatic footer
        create_dramatic_footer(console)
        
        return 0
        
    except KeyboardInterrupt:
        console.print(f"\n⛔ [bold yellow]Script interrupted by user[/bold yellow]")
        return 130  # Standard exit code for SIGINT
    except SystemExit as e:
        # Allow clean exits to propagate
        return e.code if e.code is not None else 0
    except FileNotFoundError as e:
        console.print(f"\n📁 [bold red]File not found error![/bold red]")
        console.print(f"[dim]Could not find required file: {e.filename}[/dim]")
        console.print(f"[dim]Error details: {e}[/dim]\n")
        return 2
    except PermissionError as e:
        console.print(f"\n🔒 [bold red]Permission denied![/bold red]")
        console.print(f"[dim]Cannot access: {e.filename}[/dim]")
        console.print(f"[dim]Error details: {e}[/dim]\n")
        return 13
    except Exception as e:
        console.print(f"\n💥 [bold red]CATASTROPHIC FAILURE![/bold red]")
        console.print(f"[dim]The spirit encountered an unexpected error: {e}[/dim]")

        # Add full traceback for debugging
        console.print(f"\n[dim]Full traceback for debugging:[/dim]")
        console.print(f"[dim]{traceback.format_exc()}[/dim]\n")
        return 1


if __name__ == "__main__":
    # Run the dramatic hello world
    exit_code = main()
    sys.exit(exit_code)